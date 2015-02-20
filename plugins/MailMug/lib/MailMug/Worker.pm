package MailMug::Worker;
use strict;
use warnings;
use base qw( TheSchwartz::Worker );
use MT;
use MT::Util qw( is_valid_email );
use MailMug::Mailer;

sub grab_for { 60 * 10 }
sub retry_delay { 30 }
sub max_retries { 10 }

sub sighandler {
    warn "caught signal @_\n";
    no warnings 'redefine';
    *TheSchwartz::work_once = sub { exit };
}

sub work {
  my ( $class, $job ) = @_;
  if ( _process( $job ) ) {
      $job->completed();
  } else {
      $job->failed( 'Sending failed.' );
  }
}

sub _process {
    my ( $job ) = @_;
    my $plugin = MT->component( 'MailMug' );
    my $arg = $job->arg;
    my $mail = $arg->{ mail };
    require MIME::Base64;
    require Encode;
    my $subject = Encode::decode_utf8( MIME::Base64::decode_base64( $mail->{ subject_base64 } ) );
    my $cfg = MT->config;
    my $from_addr = $cfg->EmailAddressMain;
    my $reply_to =
        $plugin->get_config_value( 'reply_to', "blog:@{[ $arg->{ blog_id } ]}" ) ||
        $cfg->EmailReplyTo ||
        $cfg->EmailAddressMain;
    my $return_path =
        $plugin->get_config_value( 'return_path', "blog:@{[ $arg->{ blog_id } ]}" ) ||
        $from_addr;
    $from_addr = undef if $from_addr && !is_valid_email( $from_addr );
    $reply_to  = undef if $reply_to  && !is_valid_email( $reply_to );
    $return_path  = undef if $return_path  && !is_valid_email( $return_path );
    my $subscripter_class = MT->model( 'mail_mug_subscripter' );
    my @subscripters = $subscripter_class->load( { job_key => $job->uniqkey } );

    my $success = 1;
    foreach my $subscripter ( @subscripters ) {
        my $mail_mug_id = $arg->{ entry_id } . '-' . $subscripter->id;
        $subscripter_class->begin_work();
        # http://takeyuweb.hatenablog.com/entry/2015/02/14/170117
        if ( $subscripter->exists() ) {
            eval {
                my %header = (
                    id => 'mail_mug',
                    $from_addr ? ( From       => $from_addr ) : (),
                    $reply_to  ? ( 'Reply-To' => $reply_to )  : (),
                    $return_path ? ( 'Return-Path' => $return_path ) : (),
                    'X-MailMug-ID' => $mail_mug_id,
                    To => $subscripter->email,
                    Subject => $subject,
                    'Content-Type' => $mail->{ content_type },
                    'Content-Transfer-Encoding' => $mail->{ content_transfer_encoding }
                );
                my $body = $mail->{ body };

                $subscripter->remove
                    or die $subscripter->errstr;
                MailMug::Mailer->send( \%header, $body )
                    or die MailMug::Mailer->errstr;
            };
            if ( my $errstr = $@ ) {
                $subscripter_class->rollback();
                require MT::Log;
                MT->log({
                    blog_id => $job->{ arg }->{ blog_id },
                    message => $errstr,
                    metadata => Data::Dumper->Dump([ $job->arg ]),
                    level => MT::Log::ERROR()
                });
                $success = 0;
                next;
            }
        }
        $subscripter_class->commit();
    }
    return $success;
}

1;

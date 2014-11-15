package MailMug::Worker;
use strict;
use warnings;
use base qw( TheSchwartz::Worker );
use MT;
use MT::Util qw( is_valid_email );
use MT::Mail;

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
  #eval {
    if ( _process( $job ) ) {
        $job->completed();
    } else {
        $job->failed( 'Sending failed.', 1 );
    }
  #};
  if ( my $errstr = $@ ) {
      require MT::TheSchwartz;
      MT::TheSchwartz->debug( $errstr );
      $job->permanent_failure( $errstr );
      require MT::Log;
      MT->log({
          blog_id => $job->{ arg }->{ blog_id },
          message => $errstr,
          metadata => Data::Dumper->Dump([ $job->arg ]),
          level => MT::Log::ERROR()
      });
  }
}

sub _process {
    my ( $job ) = @_;
    my $arg = $job->arg;
    my $mail = $arg->{ mail };
    my $cfg = MT->config;
    my $from_addr = $cfg->EmailAddressMain;
    my $reply_to = $cfg->EmailReplyTo || $cfg->EmailAddressMain;
    $from_addr = undef if $from_addr && !is_valid_email( $from_addr );
    $reply_to  = undef if $reply_to  && !is_valid_email( $reply_to );
    my @subscripters = MT->model( 'mail_mug_subscripter' )->load( { job_key => $job->uniqkey } );
    foreach my $subscripter ( @subscripters ) {
        my %header = (
            $from_addr ? ( From       => $from_addr ) : (),
            $reply_to  ? ( 'Reply-To' => $reply_to )  : (),
            To => $subscripter->email,
            Subject => $mail->{ subject },
            'Content-Type' => $mail->{ content_type },
        );
        my $body = $mail->{ body };
        unless ( MT::Mail->send( \%header, $body ) ) {
            require MT::Log;
            MT->log({
                blog_id => $job->{ arg }->{ blog_id },
                message => MT::Mail->errstr,
                metadata => Data::Dumper->Dump([ $job->arg ]),
                level => MT::Log::ERROR()
            });
            return 0;
        }
        $subscripter->remove
            or die $subscripter->errstr;
    }
    return 1;
}

1;

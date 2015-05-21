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
    my $subscripter_class = MT->model( 'mail_mug_subscripter' );
    my @subscripters = $subscripter_class->load( { job_key => $job->uniqkey } );

    my $success = 1;
    foreach my $subscripter ( @subscripters ) {
        my $mail_mug_id = $arg->{ entry_id } . '-' . $subscripter->id;
        $subscripter_class->begin_work();
        # http://takeyuweb.hatenablog.com/entry/2015/02/14/170117
        if ( $subscripter->exists() ) {
            eval {
                $subscripter->remove
                    or die $subscripter->errstr;
                MailMug::Util::send_mail( $mail, { to => $subscripter->email, mail_mug_id => $mail_mug_id } );
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

package MailMug::Service;
use strict;
use warnings;
use MailMug::Util qw( check_for_sending generate_key get_role find_by_sql build_mail );
use MT::Util qw( epoch2ts );
use POSIX 'floor';

sub create_job {
  my ( $entry ) = @_;

  my $mail = build_mail( $entry );

  my $role = get_role();

  require MT::TheSchwartz;
  require TheSchwartz::Job;

  my $subscripter_class = MT->model( 'mail_mug_subscripter' );
  $subscripter_class->begin_work;
  eval {
    my $count_sql = <<'SQL';
select COUNT(mt_author.author_id)
from mt_association
  INNER JOIN mt_author ON mt_author.author_id = mt_association.association_author_id
WHERE association_blog_id=? AND association_role_id=?;
SQL
    my @count_values = ( $entry->blog_id, $role->id );
    my @count_results = find_by_sql( $count_sql, \@count_values );
    my $count = $count_results[0]->{ 'COUNT(mt_author.author_id)' };

    my $limit = 100;
    my $total_page = $count / $limit;
    if ( ( $total_page - floor($total_page) ) > 0 ) {
      $total_page = floor($total_page) + 1;
    }
    for ( my $page = 1; $page <= $total_page; $page++ ) {
      my $offset = $limit * ( $page - 1 );
      my $key = generate_key(16);
      my $insert_sql = <<'SQL';
insert into mt_mail_mug_subscripter (mail_mug_subscripter_job_key, mail_mug_subscripter_email)
select ?, mt_author.author_email
from mt_association
  INNER JOIN mt_author ON mt_author.author_id = mt_association.association_author_id
WHERE association_blog_id=? AND association_role_id=?
ORDER BY mt_author.author_email
LIMIT ? OFFSET ?;
SQL
      my @insert_values = ( $key, $entry->blog_id, $role->id, $limit, $offset );
      find_by_sql( $insert_sql, \@insert_values );

      my $job = TheSchwartz::Job->new();
      $job->funcname( 'MailMug::Worker' );
      $job->arg( { blog_id => $entry->blog_id, entry_id => $entry->id, mail => $mail } );
      $job->uniqkey( $key );
      MT::TheSchwartz->insert($job);
    }

    my $ts = epoch2ts( $entry->blog, time );
    $entry->meta( 'field.mail_mug_sent_on', $ts );
    $entry->save or die $entry->errstr;
  };
  if ( my $errstr = $@ ) {
    $subscripter_class->rollback;
    require MT::Log;
    MT->log({
      message => $errstr,
      metadata => $entry->id,
      class => 'MT::Log::Entry',
      level => MT::Log::ERROR()
    });
  } else {
    $subscripter_class->commit;
  }
}

1;
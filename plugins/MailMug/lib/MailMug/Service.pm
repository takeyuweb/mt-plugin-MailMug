package MailMug::Service;
use strict;
use warnings;
use MailMug::Util qw( check_for_sending generate_key get_roles find_by_sql build_mail );
use MT::Util qw( epoch2ts );
use POSIX 'floor';

sub create_job {
  my ( $entry ) = @_;

  my $mail = build_mail( $entry );

  my @role_ids = map { $_->id } get_roles();
  return unless @role_ids;

  require MT::TheSchwartz;
  require TheSchwartz::Job;

  my $subscripter_class = MT->model( 'mail_mug_subscripter' );
  $subscripter_class->driver->begin_work; # 直接driverを叩いてSQL INSERTするので
  eval {
    my $count_sql = <<"SQL";
select COUNT(DISTINCT mt_author.author_id) AS cnt
from mt_association
  INNER JOIN mt_author ON mt_author.author_id = mt_association.association_author_id
WHERE association_blog_id=? AND association_role_id IN (@{[ join ',', map{'?'} @role_ids ]});
SQL
    my @count_values = ( $entry->blog_id, @role_ids );
    my @count_results = find_by_sql( $count_sql, \@count_values );
    my $count = $count_results[0]->{ 'cnt' };

    my $limit = 100;
    my $total_page = $count / $limit;
    if ( ( $total_page - floor($total_page) ) > 0 ) {
      $total_page = floor($total_page) + 1;
    }
    for ( my $page = 1; $page <= $total_page; $page++ ) {
      my $offset = $limit * ( $page - 1 );
      my $key = generate_key(16);
      my $insert_sql = <<"SQL";
insert into mt_mail_mug_subscripter (mail_mug_subscripter_job_key, mail_mug_subscripter_email)
select DISTINCT ?, mt_author.author_email
from mt_association
  INNER JOIN mt_author ON mt_author.author_id = mt_association.association_author_id
WHERE association_blog_id=? AND association_role_id IN (@{[ join ',', map{'?'} @role_ids ]})
ORDER BY mt_author.author_email
LIMIT ? OFFSET ?;
SQL
      my @insert_values = ( $key, $entry->blog_id, @role_ids, $limit, $offset );
      find_by_sql( $insert_sql, \@insert_values );

      my $job = TheSchwartz::Job->new();
      $job->funcname( 'MailMug::Worker' );
      $job->arg( { blog_id => $entry->blog_id, entry_id => $entry->id, mail => $mail } );
      $job->uniqkey( $key );
      MT::TheSchwartz->insert($job);
    }

    my $ts = epoch2ts( $entry->blog, time );
    $entry->mm_sent_on( $ts );
    $entry->save or die $entry->errstr;
  };
  if ( my $errstr = $@ ) {
    $subscripter_class->driver->rollback;
    require MT::Log;
    MT->log({
      message => $errstr,
      metadata => $entry->id,
      class => 'MT::Log::Entry',
      level => MT::Log::ERROR()
    });
  } else {
    $subscripter_class->driver->commit;
  }
}

1;
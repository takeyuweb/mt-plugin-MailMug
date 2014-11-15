package MailMug::Util;
use strict;
use warnings;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw( check_for_sending generate_key get_role find_by_sql );

sub check_for_sending {
  my ( $entry, $orig_entry ) = @_;
  if ( $entry->class ne 'entry' ) {
    return 0;
  }
  require MT::Entry;
  if ( $entry->status == MT::Entry::RELEASE() ) {
    if ( defined $orig_entry ) {
      if ( $orig_entry != MT::Entry::RELEASE ) {
        return 1;
      }
    } else {
      return 1;
    }
  }
  return 0;
}

my @KEY_LETTERS = ('a'..'z', 'A'..'Z', 0..9);
sub generate_key {
  my ( $key_length ) = @_;
  $key_length ||= 16;
  my $str = '';
  while(length $str < $key_length) {
    $str .= @KEY_LETTERS[int rand(scalar @KEY_LETTERS)];
  }
  return $str;
}

sub get_role {
  my $plugin = MT->component( 'MailMug' );
  my $role_name = $plugin->translate( 'E-mail magazine subscribers' );
  my $role = MT->model( 'role' )->load( { name => $role_name }, { limit => 1 } );
  return $role;
}

sub find_by_sql {
  my ( $sql, $bind_values ) = @_;
  die unless $sql;
  $bind_values ||= [];

  my @result_set;

  require MT::Object;
  my $driver = MT::Object->driver;
  my $dbh = $driver->rw_handle;
  my $sth = $dbh->prepare( $sql );
  die $dbh->errstr if $dbh->errstr;
  $sth->execute( @$bind_values );
  die $sth->errstr if $sth->errstr;

  my @row;
  my $column_names = $sth->{ NAME_hash };
  my @next_row;
  @next_row = $sth->fetchrow_array();
  while ( @next_row ) {
      @row = @next_row;
      my $result = {};
      foreach my $column_name ( keys %$column_names ) {
        my $idx = $column_names->{ $column_name };
        $result->{ $column_name } = $row[ $idx ];
      }
      push @result_set, $result;

      @next_row = $sth->fetchrow_array();
  }
  $sth->finish();

  return wantarray ? @result_set : scalar \@result_set;
}

1;
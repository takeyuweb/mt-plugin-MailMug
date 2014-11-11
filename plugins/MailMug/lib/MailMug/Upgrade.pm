package MailMug::Upgrade;
use strict;
use warnings;
use MT;

sub _install_mail_mug_role {
  my $upgrader = shift;
  my $app = $upgrader->app;
  my $plugin = MT->component( 'MailMug' );
  my $role_name = $plugin->translate( 'E-mail magazine subscribers' );
  my $role = MT->model( 'role' )->get_by_key( { name => $role_name } );
  unless ( $role->id ) {
    $upgrader->progress( $plugin->translate( 'Installing a subscriber role...' ) );
    my $role_description = $plugin->translate( 'Subscribe to e-mail magazine.' );
    $role->description( $role_description );
    $role->permissions( "'subscribe_mail_mug'" );
    $role->save or $upgrader->progress( $app->translate( 'Failed.' ) );
  }
  1;
}

1;
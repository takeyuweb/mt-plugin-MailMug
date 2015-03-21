package MailMug::ConfigMgr;
use strict;
use MT;

our $cfg;
our $plugin;

sub instance {
    return $cfg if $cfg;
    $plugin = MT->component( 'MailMug' );
    $cfg = __PACKAGE__->new;
}

sub new {
    my $class = shift;
    bless {}, $class;
}

sub DebugEmailAddress {
    MT->config->DebugEmailAddress;
}

sub SMTPServer {
    $plugin->get_config_value( 'smtp_server', 'system' );
}

sub SMTPUser {
    $plugin->get_config_value( 'smtp_user', 'system' );
}

sub SMTPPassword {
    $plugin->get_config_value( 'smtp_password', 'system' );
}

sub SMTPPort {
    $plugin->get_config_value( 'smtp_port', 'system' );
}

sub SMTPAuth {
    $plugin->get_config_value( 'smtp_auth', 'system' );
}

sub SMTPTimeout {
    $plugin->get_config_value( 'smtp_timeout', 'system' );
}

1;
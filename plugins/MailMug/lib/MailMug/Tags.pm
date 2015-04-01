package MailMug::Tags;
use strict;

sub hdlr_mail_mug_app_script {
    my ( $ctx, $args ) = @_;
    MT->config->MailMugAppScript;
}

1;
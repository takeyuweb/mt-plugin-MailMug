package MailMug::Subscripter;
use strict;

use base qw( MT::Object );

__PACKAGE__->install_properties ({
  column_defs => {
    'id'      => 'integer not null auto_increment',
    'job_key' => 'string(16) not null',
    'email'   => 'string(255) not null'
  },
  indexes => {
    job_key => 1
  },
  audit => 0,
  datasource  => 'mail_mug_subscripter',
  primary_key => 'id',
});

1;
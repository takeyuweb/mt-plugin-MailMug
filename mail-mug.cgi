#!/usr/bin/perl -w

use strict;
use lib $ENV{MT_HOME}
    ? "$ENV{MT_HOME}/plugins/MailMug/lib"
    : 'plugins/MailMug/lib';
use lib $ENV{MT_HOME} ? "$ENV{MT_HOME}/lib" : 'lib';
use MT::Bootstrap App => 'MailMug::App';

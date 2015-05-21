package MailMug::CMS;
use strict;
use warnings;
use MT;
use File::Temp qw( tempfile );
use File::Basename;
use File::Spec;
use MT::Util qw( is_valid_email );
use MailMug::Util;

sub _check_perms_to_importing {
    my ( $app, $blog, $user ) = @_;
    my $perm = $user->permissions( $blog );
    foreach my $action ( qw(access_to_blog_member_list grant_role_for_blog manage_users) ) {
        $perm->can_do( $action )
            or return $app->permission_denied();
    }
}

sub start_import_subscripters {
    my $app = shift;
    my $user = $app->user
        or return $app->trans_error( 'Invalid request' );
    my $blog = $app->blog
        or return $app->trans_error( 'Invalid request' );
    _check_perms_to_importing( $app, $blog, $user );

    my %params = (
        blog_id => $blog->id,
    );
    $app->build_page('start_import_subscripters.tmpl', \%params);
}

sub import_subscripters {
    my $app = shift;
    $app->validate_magic
        or return $app->trans_error( 'Invalid request' );
    my $user = $app->user
        or return $app->trans_error( 'Invalid request' );
    my $blog = $app->blog
        or return $app->trans_error( 'Invalid request' );
    _check_perms_to_importing( $app, $blog, $user );
    my $q = $app->param;
    if ( my $fh = $q->upload( 'file' ) ) {
        my $tmp_path = $q->tmpFileName( $fh );
        my $filename = File::Basename::basename( $fh, '.*' );

        my $out = time . $app->make_magic_token;
        my $path = File::Spec->catfile( $app->config( 'TempDir' ), $out );

        open my $tmp_fh, "> $path";
        while ( read( $fh, my $buffer, 2048 ) ) {
            $buffer =~ s/\r\n/\n/g;
            $buffer =~ s/\r/\n/g;
            print $tmp_fh $buffer;
        }
        close $tmp_fh;

        my $sess_obj = MT->model( 'session' )->get_by_key( {
             id   => $out,
             kind => 'TF',
             name => $path,
        } );
        $sess_obj->start(time + 60 * 60);
        $sess_obj->save;

        my %params = (
            blog_id         => $blog->id,
            out             => $out,
            magic_token     => $app->current_magic(),
        );
        $app->build_page('import_subscripters.tmpl', \%params);
    } else {
        my $out = $app->param( 'out' ) || '';
        $out = '' if $out =~ /\W/;

        my $path = File::Spec->catfile( $app->config( 'TempDir' ), $out );
        unless ( $path && -f $path ) {
            return $app->trans_error( 'Invalid request' );
        }

        my $cursor = 0;
        my $from = $app->param( 'from' ) || 0;
        my $to = $from + MT->config->SubscribersPerImport;
        my $finished = 0;
        my $skipped = $app->param( 'skipped' ) || 0;

        local *IN;
        open IN, $path;
        while ( <IN> ) {
            $finished = 0;
            if ( $cursor >= $to ) {
                last;
            }
            my $email = $_;
            chomp $email;
            if ( $cursor >= $from ) {
                unless ( _import_user( $blog, $email ) ) {
                    $skipped++;
                }
            }
            $cursor++;
            $finished = 1;
        }
        close IN;

        unless ( $finished ) {
            my %params = (
                blog_id         => $blog->id,
                out             => $out,
                magic_token     => $app->current_magic(),
                from            => $to,
                skipped         => $skipped,
            );
            $app->build_page('import_subscripters.tmpl', \%params);
        } else {
            unlink $path;
            my $sess_obj = MT->model( 'session' )->load( {
                kind => 'TF',
                name => $path,
            }, { limit => 1 } );
            $sess_obj->remove if $sess_obj;

            my $uri =$app->uri(
                mode => 'complete_import_subscripters',
                args => {
                    blog_id => $blog->id,
                    total   => $cursor,
                    skipped => $skipped,
                }
            );
            $app->redirect( $uri );
        }
    }
}

sub _import_user {
    my ( $blog, $email ) = @_;
    unless ( is_valid_email( $email ) ) {
        my $app = MT->instance;
        my $author = $app->user;
        require MT::Log;
        MT->log({
            message => MT->translate( 'Invalid email address: [_1]', $email ),
            blog_id => $blog->id,
            lebel   => MT::Log::ERROR(),
            ip      => $app->remote_ip,
            $author ? ( author_id => $author->id ) : (),
        });
        return;
    }
    my $role = _get_role();
    my $user = MT->model( 'author' )->load( {
        type      => MT->model( 'author' )->AUTHOR(),
        auth_type => 'MT',
        email     => $email
    }, { limit => 1 } );

    unless ( defined $user ) {
        require MailMug::Util;
        $user = MailMug::Util::create_subscriber( $email );
    }
    MT->model( 'association' )->link( $user => $role => $blog );
}

sub _get_role {
    my $plugin = MT->component( 'MailMug' );
    my $role_name = $plugin->get_config_value( 'imported_user_role', 'system' )
        || $plugin->translate( 'E-mail magazine subscribers' );
    my $role = MT->model( 'role' )->load( { name => $role_name } )
        or die "Please check the setting of 'Imported user's default role'.";
    return $role;
}

sub complete_import_subscripters {
    my $app = shift;
    my $user = $app->user
        or return $app->trans_error( 'Invalid request' );
    my $blog = $app->blog
        or return $app->trans_error( 'Invalid request' );
    _check_perms_to_importing( $app, $blog, $user );

    my %params = (
        blog_id => $blog->id,
        total   => $app->param( 'total' ),
        skipped => $app->param( 'skipped' ),
    );
    $app->build_page('complete_import_subscripters.tmpl', \%params);
}

sub email_testing {
    my $app = shift;
    my $user = $app->user
        or return $app->trans_error( 'Invalid request' );
    my $blog = $app->blog
        or return $app->trans_error( 'Invalid request' );
    return $app->trans_error( 'Invalid request' )
        unless MailMug::Util::mail_mug_enabled( $blog );
    my $entry_id = $app->param('entry_id')
        or return $app->error( $app->translate("No entry ID was provided") );

    require MT::Promise;
    my $promise = MT::Promise::delay(
        sub {
            return MT->model( 'entry' )->load( { id => $entry_id, blog_id => $blog->id, class => 'entry' } ) || undef;
        }
    );
    return $app->permission_denied()
        unless $app->run_callbacks( 'cms_view_permission_filter.entry', $app, $entry_id, $promise );

    my $entry = $promise->force;

    my %params = (
        entry_id => $entry_id,
        doing => ( $app->mode eq 'do_email_testing' ? 1 : 0)
    );
    MailMug::Util::build_page( 'email_testing', { entry => $entry }, \%params );
}

sub do_email_testing {
    my $app = shift;
    my $user = $app->user
        or return $app->trans_error( 'Invalid request' );
    my $blog = $app->blog
        or return $app->trans_error( 'Invalid request' );
    return $app->trans_error( 'Invalid request' )
        unless MailMug::Util::mail_mug_enabled( $blog );
    my $entry_id = $app->param('entry_id')
        or return $app->error( $app->translate("No entry ID was provided") );
    return $app->errtrans( "Invalid request." )
        unless $app->validate_magic();

    require MT::Promise;
    my $promise = MT::Promise::delay(
        sub {
            return MT->model( 'entry' )->load( { id => $entry_id, class => 'entry' } ) || undef;
        }
    );
    return $app->permission_denied()
        unless $app->run_callbacks( 'cms_view_permission_filter.entry', $app, $entry_id, $promise );

    my $entry = $promise->force;

    my @recipients = split /\r?\n/, $app->param( 'recipients' );
    @recipients = grep { is_valid_email( $_ ) } @recipients;
    return email_testing( $app ) unless ( @recipients );

    my $mail = MailMug::Util::build_mail( $entry );

    foreach my $recipient ( @recipients ) {
        my $mail_mug_id = $entry->id . '-test';
        MailMug::Util::send_mail( $mail, { to => $recipient, mail_mug_id => $mail_mug_id } );
    }

    $app->build_page( 'email_testing_completed.tmpl', { recipients => \@recipients } );
}

1;
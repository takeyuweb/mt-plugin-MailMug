package MailMug::CMS;
use strict;
use warnings;
use MT;
use File::Temp qw( tempfile );
use File::Basename;
use File::Spec;
use MT::Util;

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
        my $to = $from + 100;
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
    my $role = _get_role();
    my $user = MT->model( 'author' )->load( { email => $email }, { limit => 1 } );
    unless ( defined $user ) {
        $user = MT->model( 'author' )->new;
        $user->set_defaults();
        $user->set_values( {
            name               => $email,
            nickname           => $email,
            email              => $email,
            type               => MT->model( 'author' )->AUTHOR(),
            status             => MT->model( 'author' )->ACTIVE(),
            auth_type          => 'MT',
        } );
        my @alpha  = ( 'a' .. 'z', 'A' .. 'Z', 0 .. 9 );
        my $password   = join '', map $alpha[ rand @alpha ], 1 .. 16;
        $user->set_password( $password );
        my $basename = MT::Util::make_unique_author_basename( $user );
        $user->basename( $basename );
        $user->save or die $user->errstr;
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
        total => $app->param( 'total' )
    );
    $app->build_page('complete_import_subscripters.tmpl', \%params);
}

1;
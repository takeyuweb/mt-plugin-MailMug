package MailMug::App;
use strict;
use base qw( MT::App );
use MT::Util qw( is_valid_email );
use MailMug::Util;

sub id { 'mail_mug' }

sub init {
    my $app = shift;
    $app->SUPER::init( @_ );
    $app->{ default_mode } = 'form';
    $app;
}

sub add {
    my $app = shift;
    my $blog = $app->blog or
        return $app->trans_error( 'Invalid request' );
    unless ( MailMug::Util::mail_mug_enabled( $blog ) ) {
        return $app->trans_error( 'Invalid request' );
    }

    if ( $app->request_method() ne 'POST' ) {
        return $app->form();
    }

    $app->validate_magic or
        return $app->form( invalid_magic => 1 );

    my $email = $app->param( 'email' ) or
        return $app->form( missing => 1 );
    is_valid_email( $email ) or
        return $app->form( invalid => 1 );

    my %terms = (
        email     => $email,
        type      => MT->model( 'author' )->AUTHOR(),
        auth_type => 'MT'
    );
    my $author = MT->model( 'author' )->load( \%terms, { limit => 1 } );
    if ( defined $author ) {
        if ( $author->status == MT->model( 'author' )->INACTIVE() ) {
            return $app->form( banned => 1 );
        }
    } else {
        $author = MailMug::Util::create_subscriber( $email );
    }
    my $role = $app->_get_role();
    MT->model( 'association' )->link( $author => $role => $blog );

    my $uri =$app->uri(mode => 'form',
                    args => {
                        blog_id => $blog->id,
                        added => 1,
                    }
                );
    $app->redirect( $uri );
}

sub remove {
    my $app = shift;
    my $blog = $app->blog or
        return $app->trans_error( 'Invalid request' );
    unless ( MailMug::Util::mail_mug_enabled( $blog ) ) {
        return $app->trans_error( 'Invalid request' );
    }

    if ( $app->request_method() ne 'POST' ) {
        return $app->form();
    }

    $app->validate_magic or
        return $app->form( invalid_magic => 1 );

    my $email = $app->param( 'email' ) or
        return $app->form( missing => 1 );
    is_valid_email( $email ) or
        return $app->form( invalid => 1 );

    my %terms = (
        email     => $email,
        type      => MT->model( 'author' )->AUTHOR(),
        auth_type => 'MT'
    );
    my $author = MT->model( 'author' )->load( \%terms, { limit => 1 } );
    if ( defined $author ) {
        my $role = $app->_get_role();
        MT->model( 'association' )->unlink( $author => $role => $blog );
    }

    my $uri =$app->uri(mode => 'form',
                    args => {
                        blog_id => $blog->id,
                        removed => 1,
                    }
                );
    $app->redirect( $uri );
}

sub form {
    my $app = shift;
    if ( $app->mode ne 'form' ) {
        my %params = @_;
        foreach my $key ( keys %params ) {
            $app->param( $key, $params{ $key } );
        }
    }

    my $blog = $app->blog or
        return $app->trans_error( 'Invalid request' );
    unless ( MailMug::Util::mail_mug_enabled( $blog ) ) {
        return $app->trans_error( 'Invalid request' );
    }
    my $plugin = MT->component( 'MailMug' );

    require MT::Template;
    require MT::Template::Context;
    my $tmpl = MT::Template->load( {
        type    => 'mail_mug_form',
        blog_id => $blog->id
    } );
    unless ( defined $tmpl ) {
        $tmpl = $plugin->load_tmpl( 'templates/mail_mug_form.mtml' );
    }
    my $ctx  = MT::Template::Context->new;
    $ctx->stash( 'blog', $blog );
    $tmpl->context( $ctx );
    $app->set_default_tmpl_params( $tmpl );

    my $magic_token = $app->current_magic || $app->make_magic_token;
    $app->_bake_magic_token( $magic_token );

    $tmpl->param( {
        magic_token => $magic_token,
        blog_id     => $blog->id,
    } );

    my $body = $tmpl->build( $ctx );
    return $body;
}

sub _bake_magic_token {
    my $app = shift;
    my ( $magic_token ) = @_;
    my %kookee = (
        -name  => 'mail_mug_token',
        -value => $magic_token,
        -httponly => 1
    );
    $app->bake_cookie( %kookee );
}

sub validate_magic {
    my $app = shift;
    return ( $app->current_magic || '' ) eq ( $app->param('magic_token') || '' );
}

sub current_magic {
    my $app  = shift;
    my %cookies = $app->cookies();
    if ( $cookies{ mail_mug_token } ) {
        return $cookies{ mail_mug_token }->value();
    } else {
        return;
    }
}

sub _get_role {
    my $app = shift;
    my $blog = $app->blog;
    my $plugin = MT->component( 'MailMug' );
    my $role_name = $plugin->get_config_value( 'role_for_form', "blog:@{[ $blog->id ]}" )
        || $plugin->translate( 'E-mail magazine subscribers' );
    my $role = MT->model( 'role' )->load( { name => $role_name } )
        or die "Please check the setting of 'Role for subscription form'.";
    return $role;
}

1;
__END__

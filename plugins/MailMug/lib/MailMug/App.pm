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
    }
    my $key = MailMug::Util::create_email_confirmation( $email );

    require MIME::Base64;
    my $title = $app->_build_confirmation_mail_tmpl( 'mail_mug_confirmation_sub', $email, $key );
    my $html = $app->_build_confirmation_mail_tmpl( 'mail_mug_confirmation', $email, $key );
    my $text = $app->_build_confirmation_mail_tmpl( 'mail_mug_confirmation_txt', $email, $key );

    require Encode;
    require MIME::Entity;
    my $mime = MIME::Entity->build( Type => 'multipart/alternative' );
    $mime->attach(
        Type    => 'text/plain;charset="utf-8"',
        Data    => [ Encode::encode_utf8( $text ) ],
        Encoding => 'base64',                           # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
    );

    my $related = $mime->attach( Type => 'multipart/related' );
    $related->attach(
        Type    => 'text/html;charset="UTF-8"',
        Data    => [ Encode::encode_utf8( $html ) ],
        Encoding => 'base64',                               # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
    );

    my $head = $mime->head;
    my $content_transfer_encoding = '7bit';
    my $content_type = $head->get( 'Content-Type' );
    my $body = $mime->stringify_body;
    my $encoded_subject = MIME::Base64::encode_base64( Encode::encode_utf8( $title ) );
    my %mail = (
        subject_base64 => $encoded_subject,    # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
        content_type => $content_type,
        content_transfer_encoding => $content_transfer_encoding,
        body => $body,
        blog_id => $blog->id
    );
    MailMug::Util::send_mail( \%mail, { to => $email } )
        or die 'Confirmation sending error';

    my $uri =$app->uri(mode => 'form',
                    args => {
                        blog_id => $blog->id,
                        added => 1,
                    }
                );
    $app->redirect( $uri );
}

sub _build_confirmation_mail_tmpl {
    my $app = shift;
    my ( $tmpl_type, $email, $key ) = @_;
    my $blog = $app->blog;
    my $blog_id = $blog->id;
    require MT::Template;
    require MT::Template::Context;
    my $tmpl = MT::Template->load( {
        type    => $tmpl_type,
        blog_id => $blog_id,
    } );
    unless ( defined $tmpl ) {
        require File::Spec;
        my $plugin = MT->component( 'MailMug' );
        $tmpl = $plugin->load_tmpl( File::Spec->catfile( 'templates', "@{[ $tmpl_type ]}.mtml" ) );
    }
    $app->set_default_tmpl_params( $tmpl );

    my $ctx  = MT::Template::Context->new;
    $ctx->stash( 'blog', $blog );
    $ctx->{ __stash }->{ vars }->{ blog_id } = $blog_id;
    $ctx->{ __stash }->{ vars }->{ key } = $key;
    $ctx->{ __stash }->{ vars }->{ email } = $email;
    $tmpl->context( $ctx );

    my $body = $tmpl->build( $ctx );
}

sub submit {
    my $app = shift;
    my $blog = $app->blog or
        return $app->trans_error( 'Invalid request' );
    unless ( MailMug::Util::mail_mug_enabled( $blog ) ) {
        return $app->trans_error( 'Invalid request' );
    }

    my $key = $app->param( 'key' );
    my $author = MailMug::Util::verify_email_confirmation( $key );
    if ( $author ) {
        my $role = $app->_get_role();
        my $association_terms =
            MT->model( 'association' )->objects_to_terms(
                $author => $role => $blog );
        if ( MT->model( 'association' )->count( $association_terms ) == 0 ) {
            MT->model( 'association' )->link( $author => $role => $blog );
            MT->log({
                message  => MT->translate( 'The user has subscribed to the e-mail magazine.' ),
                blog_id     => $blog->id,
                lebel        => MT::Log::INFO(),
                ip            => $app->remote_ip,
                author_id  => $author->id,
                metadata => $author->email
            });
        }

    }
    my $uri =$app->uri(mode => 'form',
                    args => {
                        blog_id => $blog->id,
                        confirmed => $author ? 1 : 0,
                        expired => $author ? 0 : 1,
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
    my @authors = MT->model( 'author' )->load( \%terms );
    if ( @authors ) {
        foreach my $author ( @authors ) {
            my $role = $app->_get_role();
            my $association_terms =
                MT->model( 'association' )->objects_to_terms( $author => $role => $blog );
            if ( MT->model( 'association' )->count( $association_terms ) ) {
                MT->model( 'association' )->unlink( $author => $role => $blog );
                MT->log({
                    message => MT->translate( 'The user has canceled subscription of e-mail magazine.' ),
                    blog_id    => $blog->id,
                    lebel       => MT::Log::INFO(),
                    ip           => $app->remote_ip,
                    author_id => $author->id,
                    metadata => $email
                });
            }
        }
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

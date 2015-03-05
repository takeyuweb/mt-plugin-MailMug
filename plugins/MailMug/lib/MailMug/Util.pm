package MailMug::Util;
use strict;
use warnings;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw( check_for_sending generate_key get_roles find_by_sql build_mail csv );

sub check_for_sending {
  my ( $entry, $orig_entry ) = @_;
  if ( $entry->class ne 'entry' ) {
    return 0;
  }
  require MT::Entry;
  if ( $entry->status == MT::Entry::RELEASE() ) {
    my $sent_on = $entry->meta( 'field.mail_mug_sent_on' );
    if ( $sent_on ) {
        return 0;
    }
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

sub get_roles {
  my @roles = MT->model( 'role' )->load(
    { permissions => "\%'subscribe_mail_mug'\%" },
    { 'like' => { 'permissions' => 1 } });
  return @roles;
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

sub build_mail {
    my ( $entry ) = @_;
    require MIME::Base64;

    my $title = _build_mail_entry_tmpl( $entry, 'mail_mug_subject' );
    my $html = _build_mail_entry_tmpl( $entry, 'mail_mug_html_body' );
    my $ref_attachment_map = _cut_attachments( $entry, \$html );
    my $text = _build_mail_entry_tmpl( $entry, 'mail_mug_text_body' );

    my $plugin = MT->component( 'MailMug' );
    my $mail_format = $plugin->get_config_value( 'mail_format', "blog:@{[ $entry->blog_id ]}" ) || 'default';
    my $mail_encoding = $plugin->get_config_value( 'mail_encoding', "blog:@{[ $entry->blog_id ]}" ) || 'utf-8';

    my ( $content_transfer_encoding, $content_type, $body );
    if ( $mail_format eq 'plain' ) {
        if ( $mail_encoding eq 'jis' ) {
            $content_type = 'text/plain;charset="iso-2022-jp"';
            $body = Encode::encode( 'jis', $text );
            $content_transfer_encoding = '7bit';
        } else {
            $content_type = 'text/plain;charset="utf-8"';
            $body = MIME::Base64::encode_base64( Encode::encode_utf8( $text ) );
            $content_transfer_encoding = 'base64';
        }
    } else {
        require Encode;
        require MIME::Entity;
        my $mime = MIME::Entity->build(
                Type => 'multipart/alternative',
            );
        if ( $mail_format eq 'default' ) {
            if ( $mail_encoding eq 'jis' ) {
                $mime->attach(
                        Type    => 'text/plain;charset="iso-2022-jp"',
                        Data    => [ Encode::encode( 'jis', $text ) ],  # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
                        Encoding    => "7bit",
                );
            } else {
                $mime->attach(
                        Type    => 'text/plain;charset="utf-8"',
                        Data    => [ Encode::encode_utf8( $text ) ],
                        Encoding => 'base64',                           # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
                );
            }
        }
        my $related = $mime->attach( Type => 'multipart/related' );
        if ( $mail_encoding eq 'jis' ) {
            $related->attach(
                    Type    => 'text/html;charset="iso-2022-jp"',
                    Data    => [ Encode::encode( 'jis', $html ) ],
                    Encoding => '7bit',                                 # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
            );
        } else {
            $related->attach(
                   Type    => 'text/html;charset="UTF-8"',
                    Data    => [ Encode::encode_utf8( $html ) ],
                    Encoding => 'base64',                               # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
            );
        }
        foreach my $cid ( keys %$ref_attachment_map ) {
            my $path = $ref_attachment_map->{ $cid };
            $related->attach(
                    'Content-ID' => "<$cid>",
                    'X-Attachment-Id' => $cid,
                    Type    => 'image/jpeg',
                    Path    => $path,
                    Encoding => 'base64',
                    Disposition => 'attachment'
                );
        }

        my $head = $mime->head;
        #$content_transfer_encoding = $head->get( 'Content-Transfer-Encoding' );
        $content_transfer_encoding = '7bit';
        $content_type = $head->get( 'Content-Type' );
        $body = $mime->stringify_body;
    }

    my $encoded_subject = MIME::Base64::encode_base64( Encode::encode_utf8( $title ) );
    my %mail = (
        subject_base64 => $encoded_subject,    # 一部バージョン(ex 5.8.8) のStorableでマルチバイト文字を含む場合復元できなくなるケース
        content_type => $content_type,
        content_transfer_encoding => $content_transfer_encoding,
        body => $body
    );
    return \%mail;
}

sub _build_mail_entry_tmpl {
    my ( $entry, $tmpl_type ) = @_;
    require MT::Template;
    require MT::Template::Context;
    my $tmpl = MT::Template->load( {
        type    => $tmpl_type,
        blog_id => $entry->blog_id
    } );
    my $ctx  = MT::Template::Context->new;
    $ctx->stash( 'entry', $entry );
    $tmpl->context( $ctx );

    my $body = $tmpl->build( $ctx );
    return $body;
}

sub _cut_attachments {
    my ( $entry, $ref_html ) = @_;
    my $blog_url = $entry->blog->site_url;
    my $host;
    if ( $blog_url =~ m!^https?://([^/:]+)(:\d+)?/?! ) {
        $host = $1;
    } else {
        $host = 'mail-mug.mail';
    }

    my %map_attachment;
    my $count = 0;
    require File::Spec;
    while ( $$ref_html =~ s/src="$blog_url([^"]+)"/src="cid:$count\@$host"/ ) {
        my $rel_path = $1;
        my $abs_path = File::Spec->catfile( $entry->blog->site_path, $rel_path );
        $map_attachment{ "$count\@$host" } = $abs_path;
        $count++;
        last if $count > 1;
    }
    return \%map_attachment;
}

sub csv {
    eval { require Text::CSV_XS };
    unless ( $@ ){
        Text::CSV_XS->new ( { binary => 1 } );
    }else{
        eval { require Text::CSV };
        die "Neither Text::CSV_XS nor Text::CSV is available" if $@;
        Text::CSV->new ( { binary => 1 } );
    }
}

1;

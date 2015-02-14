package MailMug::Callbacks;
use strict;
use warnings;
use MT;
use MailMug::Util qw( check_for_sending );
use MailMug::Service;

sub _hdlr_cms_post_save_entry {
  my ( $cb, $app, $obj, $orig_obj ) = @_;
  require MailMug::Service;
  if ( check_for_sending( $obj, $orig_obj ) ) {
    MailMug::Service::create_job( $obj );
  }
  1;
}

sub _hdlr_cms_post_bulk_save_entries {
  my ( $cb, $app, $ref_objects ) = @_;
  foreach my $data ( @$ref_objects ) {
    my $obj = $data->{ current };
    my $orig_obj = $data->{ original };
    if ( check_for_sending( $obj, $orig_obj ) ) {
      MailMug::Service::create_job( $obj );
    }
  }
}

sub _hdlr_scheduled_post_published {
  my ( $cb, $mt, $obj ) = @_;
  if ( check_for_sending( $obj ) ) {
    MailMug::Service::create_job( $obj );
  }
}

sub _hdlr_append_permissions_to_edit_role {
  my ( $cb, $app, $param, $tmpl ) = @_;
  my $plugin = MT->component( 'MailMug' );
  my $pointer = $tmpl->getElementById( 'commenting' );
  my $node = $tmpl->createElement('app:setting',
      { id => 'mail_mug',
        required => 0,
        label => $plugin->translate( 'E-mail magazine' )});
  my $inner_html = <<"MTML";
      <ul class="fixed-width">
        <mt:loop name="loaded_permissions">
        <mt:if name="group" eq="mail_mug">
          <li><label for="<mt:var name="id">"><input id="<mt:var name="id">" type="checkbox" onclick="togglePerms(this, '<mt:var name="children">')" class="<mt:var name="id"> cb" name="permission" value="<mt:var name="id">"<mt:if name="can_do"> checked="checked"</mt:if>> <mt:var name="label" escape="html"></label></li>
        </mt:if>
        </mt:loop>
      </ul>
MTML
  $node->innerHTML( $inner_html );
  $tmpl->insertAfter( $node, $pointer );
}

sub _hdlr_mail_filter_content_transfer_encoding_overwriting {
  my $cb = shift;
  my %params = @_;
  # args     => $hdrs_arg,
  # headers  => \%hdrs,
  # body     => \$body,
  # transfer => \$xfer,
  # ( $id ? ( id => $id ) : () )
  if ( $params{ id } && $params{ id } eq 'mail_mug' ) {
    if ( $params{ args }->{ 'Content-Transfer-Encoding' } ) {
      $params{ headers }->{ 'Content-Transfer-Encoding' } = $params{ args }->{ 'Content-Transfer-Encoding' };
    }
  }
  1;
}

1;
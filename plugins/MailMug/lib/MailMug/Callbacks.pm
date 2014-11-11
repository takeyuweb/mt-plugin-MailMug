package MailMug::Callbacks;
use strict;
use warnings;
use MT;

sub _hdlr_cms_post_save_entry {
  my ( $cb, $app, $obj, $orig_obj ) = @_;

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

1;
package MailMug::Callbacks;
use strict;
use warnings;
use MT;
use MailMug::Util qw( mail_mug_enabled check_for_sending );
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

sub _hdlr_mail_filter_overwriting {
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
    $params{ headers }->{ 'X-Mailer' } = 'MailMug';
  }
  1;
}

sub _hdlr_append_delivering_field {
  my ( $cb, $app, $param, $tmpl ) = @_;
  my $blog = $app->blog or return 1;
  my $plugin = MT->component( 'MailMug' );

  my $host_node = $tmpl->getElementById( 'entry-status-widget' );
  my $innerHTML = <<'TMPL';
<__trans_section component="MailMug">
<mt:If name="mm_sent_on" gt="0">
  <__trans phrase="Deliverd at [_1]" params="<$mt:date ts='$mm_sent_on'$>">
  <input type="hidden" name="mm_allow_delivering" value="<$mt:getvar name='mm_allow_delivering'$>">
  <input type="hidden" name="mm_sent_on" value="<$mt:getvar name='mm_sent_on' escape='html'$>">
<mt:Else>
  <input type="checkbox" name="mm_allow_delivering" id="mm_allow_delivering" value="1"<mt:if name="mm_allow_delivering"> checked="checked"</mt:if> class="cb" /> <label for="mm_allow_delivering"><__trans phrase="Allow Delivering"></label>
  <input type="hidden" name="mm_allow_delivering" value="0">
  <input type="hidden" name="mm_sent_on" value="<$mt:getvar name='mm_sent_on' escape='html'$>">
</mt:If>
</__trans_section>
<mt:Unless name="mail_mug_enabled">
<style type="text/css">
#mail_magazine { display: none; }
</style>
</mt:Unless>
TMPL
  my $block_node = $tmpl->createElement(
    'app:widget',
    {
      id => 'mail_magazine',
      label => $plugin->translate( 'E-mail magazine' ),
      label_class => 'top-label',
    }
  );
  $block_node->innerHTML( $innerHTML );
  $tmpl->insertAfter($block_node, $host_node);

  if ( $app->param( 'reedit' ) ) {
    $param->{ mm_allow_delivering } = $app->param( 'mm_allow_delivering' );
  }

  if ( mail_mug_enabled( $blog ) ) {
    $param->{ mail_mug_enabled } = 1;
  }
  1;
}

sub _hdlr_mail_filter_sending_intercept {
  my $cb = shift;
  my %params = @_;
  # args     => $hdrs_arg,
  # headers  => \%hdrs,
  # body     => \$body,
  # transfer => \$xfer,
  # ( $id ? ( id => $id ) : () )
  if ( $params{ id } && $params{ id } eq 'mail_mug' ) {
    my $plugin = MT->component( 'MailMug' );
    my $mail_mug_smtp = $plugin->get_config_value( 'mail_mug_smtp', 'system' );
    if ( $mail_mug_smtp ) {
      require MailMug::Mailer;
      require MailMug::ConfigMgr;
      my $ref_hdrs = $params{ headers };
      my $ref_body = $params{ body };
      my $mgr = MailMug::ConfigMgr->instance;
      MailMug::Mailer->_send_mt_smtp( $ref_hdrs, $$ref_body, $mgr );
      return 0;
    }
  }
  1;
}

1;
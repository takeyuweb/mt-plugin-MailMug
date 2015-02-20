package MailMug::Mailer;
use strict;
use warnings;
use MT::Mail;
use Sys::Hostname;
use base 'MT::Mail';

sub send {
    my $self = shift;
    my ( $hdrs_arg, $body ) = @_;
    my $mail_mug_id = $hdrs_arg->{ 'X-MailMug-ID' };
    local $hdrs_arg->{ 'Return-Path' } = $hdrs_arg->{ 'Return-Path' };
    my $return_path = delete $hdrs_arg->{ 'Return-Path' };
    if (  $return_path ) {
        MT->request("return_path.@{[ $mail_mug_id ]}", $return_path);
    }
    my $ret = $self->SUPER::send( $hdrs_arg, $body );
    MT->request("return_path.@{[ $mail_mug_id ]}", undef);
    return $ret;
}

# Copy from lib/MT/Mail.pm
my %SMTPModules = (
    Core => [ 'Net::SMTP', 'MIME::Base64' ],
    Auth => ['Authen::SASL'],
    SSL => [ 'Net::SMTP::SSL', 'IO::Socket::SSL', 'Net::SSLeay' ],
    TLS => [ 'Net::SMTP::TLS', 'IO::Socket::SSL', 'Net::SSLeay' ],
);
use MT::Util qw(is_valid_email);
sub _send_mt_smtp {
    my $class = shift;
    my ( $hdrs, $body, $mgr ) = @_;
    $hdrs->{To} = $mgr->DebugEmailAddress
        if ( is_valid_email( $mgr->DebugEmailAddress || '' ) );

    # SMTP Configuration
    my $host      = $mgr->SMTPServer;
    my $user      = $mgr->SMTPUser;
    my $pass      = $mgr->SMTPPassword;
    my $localhost = hostname() || 'localhost';
    my $port
        = $mgr->SMTPPort          ? $mgr->SMTPPort
        : $mgr->SMTPAuth eq 'ssl' ? 465
        :                           25;
    my ( $auth, $tls, $ssl );
    if ( $mgr->SMTPAuth ) {

        if ( 'starttls' eq $mgr->SMTPAuth ) {
            $tls = 1;
        }
        elsif ( 'ssl' eq $mgr->SMTPAuth ) {
            $ssl  = 1;
            $auth = 1;
        }
        else {
            $auth = 1;
        }
    }

    return $class->error(
        MT->translate(
            "Username and password is required for SMTP authentication."
        )
        )
        if ( $tls or $auth )
        and ( !$user or !$pass );

    # Check required modules;
    my $mod_reqd;
    my @modules = ();
    push @modules, @{ $SMTPModules{Core} };
    push @modules, @{ $SMTPModules{Auth} } if $auth;
    push @modules, @{ $SMTPModules{SSL} } if $ssl;
    push @modules, @{ $SMTPModules{TLS} } if $tls;

    $class->can_use( \@modules ) or return;

    # Make a smtp object
    my $smtp;

    if ($tls) {
        $smtp = Net::SMTP::TLS->new(
            $host,
            Port     => $port,
            User     => $user,
            Password => $pass,
            Timeout  => $mgr->SMTPTimeout,
            Hello    => $localhost,
            ( $MT::DebugMode ? ( Debug => 1 ) : () ),
            )
            or return $class->error(
            MT->translate(
                'Error connecting to SMTP server [_1]:[_2]',
                $host, $port
            )
            );
    }
    elsif ($ssl) {
        $smtp = Net::SMTP::SSL->new(
            $host,
            Port    => $port,
            Timeout => $mgr->SMTPTimeout,
            Hello   => $localhost,
            ( $MT::DebugMode ? ( Debug => 1 ) : () ),
            )
            or return $class->error(
            MT->translate(
                'Error connecting to SMTP server [_1]:[_2]',
                $host, $port
            )
            );
    }
    else {
        $smtp = Net::SMTP->new(
            $host,
            Port    => $port,
            Timeout => $mgr->SMTPTimeout,
            Hello   => $localhost,
            ( $MT::DebugMode ? ( Debug => 1 ) : () ),
            )
            or return $class->error(
            MT->translate(
                'Error connecting to SMTP server [_1]:[_2]',
                $host, $port
            )
            );
    }

    if ($auth) {
        if ( !$smtp->auth( $user, $pass ) ) {
            return $class->error(
                MT->translate(
                    "Authentication failure: [_1]",
                    $smtp->message
                )
            );
        }
    }

    # Set sender header if smtp user id is valid email
    $hdrs->{Sender} = $user if MT::Util::is_valid_email($user);

    # Setup headers
    my $hdr;
    foreach my $k ( keys %$hdrs ) {
        next if ( $k =~ /^(To|Bcc|Cc)$/ );
        $hdr .= "$k: " . $hdrs->{$k} . "\r\n";
    }

# CUSTOMIZE
    # Sending mail
    #$smtp->mail( $hdrs->{From} );
my $mail_mug_id = $hdrs->{ 'X-MailMug-ID' };
$mail_mug_id = MIME::EncWords::decode_mimewords($mail_mug_id);

if ( my $return_path = MT->request("return_path.@{[ $mail_mug_id ]}") ) {
    $smtp->mail( $return_path )if MT::Util::is_valid_email($return_path);
} else {
    $smtp->mail( $hdrs->{From} );
}
# /CUSTOMIZE

    foreach my $h (qw( To Bcc Cc )) {
        if ( defined $hdrs->{$h} ) {
            my $addr = $hdrs->{$h};
            $addr = [$addr] unless 'ARRAY' eq ref $addr;
            foreach my $a (@$addr) {
                $smtp->recipient($a);
            }
            $hdr .= "$h: " . join( ",\r\n ", @$addr ) . "\r\n";
        }
    }

    $smtp->data();
    $smtp->datasend($hdr);
    $smtp->datasend("\n");
    $smtp->datasend($body);
    $smtp->dataend();
    $smtp->quit;
    1;
}

my @Sendmail
    = qw( /usr/lib/sendmail /usr/sbin/sendmail /usr/ucblib/sendmail );

sub _send_mt_sendmail {
    my $class = shift;
    my ( $hdrs, $body, $mgr ) = @_;
    $hdrs->{To} = $mgr->DebugEmailAddress
        if ( is_valid_email( $mgr->DebugEmailAddress || '' ) );
    my $sm_loc;
    for my $loc ( $mgr->SendMailPath, @Sendmail ) {
        next unless $loc;
        $sm_loc = $loc, last if -x $loc && !-d $loc;
    }
    return $class->error(
        MT->translate(
                  "You do not have a valid path to sendmail on your machine. "
                . "Perhaps you should try using SMTP?"
        )
    ) unless $sm_loc;
    local $SIG{PIPE} = {};
    my $pid = open MAIL, '|-';
    local $SIG{ALRM} = sub { CORE::exit() };
    return unless defined $pid;
    if ( !$pid ) {
# CUSTOMIZE
        #exec $sm_loc, "-oi", "-t"
        #    or return $class->error(
        #    MT->translate( "Exec of sendmail failed: [_1]", "$!" ) );
my $mail_mug_id = $hdrs->{ 'X-MailMug-ID' };
$mail_mug_id = MIME::EncWords::decode_mimewords($mail_mug_id);
if ( my $return_path = MT->request("return_path.@{[ $mail_mug_id ]}") ) {
    if ( MT::Util::is_valid_email($return_path) ) {
        exec $sm_loc, "-oi", "-t", "-f$return_path"
                or return $class->error(
                MT->translate( "Exec of sendmail failed: [_1]", "$!" ) );
    }
    MT->request('return_path', undef);
} else {
    exec $sm_loc, "-oi", "-t"
            or return $class->error(
            MT->translate( "Exec of sendmail failed: [_1]", "$!" ) );
}
# /CUSTOMIZE
    }
    for my $key ( keys %$hdrs ) {
        my @arr
            = ref( $hdrs->{$key} ) eq 'ARRAY'
            ? @{ $hdrs->{$key} }
            : ( $hdrs->{$key} );
        print MAIL map "$key: $_\n", @arr;
    }
    print MAIL "\n";
    print MAIL $body;
    close MAIL;
    1;
}

1;
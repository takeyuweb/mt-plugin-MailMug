# Project modules
package 'perl-MIME-tools'

%w(Email::Sender::Transport::SMTPS Text::CSV_XS).each do |pkg|
  cpan_client pkg do
    user 'root'
    group 'root'
    force true
    install_type 'cpan_module'
    action 'install'
  end
end

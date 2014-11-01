
# Project modules
%w(Email::Sender::Transport::SMTPS).each do |pkg|
  cpan_client pkg do
    user 'root'
    group 'root'
    force true
    install_type 'cpan_module'
    action 'install'
  end
end

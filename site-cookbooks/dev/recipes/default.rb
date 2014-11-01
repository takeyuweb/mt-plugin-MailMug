#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright 2014, Yuichi Takeuchi
#
# All rights reserved - Do Not Redistribute
#

package 'php'
package 'php-mysql'
package 'httpd'
cookbook_file 'httpd.conf' do
  action :create
  path '/etc/httpd/conf/httpd.conf'
end
service 'httpd' do
  action [:enable, :start]
end

include_recipe 'mysql::server'
include_recipe 'mysql::client'

package 'curl'
package 'gcc'
include_recipe 'cpan::bootstrap'
# Required modules
%w(CGI Image::Size File::Spec CGI::Cookie LWP::UserAgent DBI DBD::mysql).each do |pkg|
  cpan_client pkg do
    user 'root'
    group 'root'
    force true
    install_type 'cpan_module'
    action 'install'
  end
end

# Option modules
include_recipe 'imagemagick'
include_recipe 'imagemagick::devel'
package 'ImageMagick-perl'
package 'perl-XML-Parser'
package 'libxml2-devel'
package 'openssl-devel'
package 'expat-devel'
package 'perl-GD'
%w(Archive::Zip XML::LibXML::SAX Crypt::SSLeay Archive::Tar IPC::Run XML::SAX::Expat XML::SAX::ExpatXS Imager CGI::PSGI Cache::Memcached Cache::File CGI::Parse::PSGI Crypt::DSA Digest::SHA1 Plack XML::Atom XMLRPC::Transport::HTTP::Plack Net::SMTP::SSL).each do |pkg|
  cpan_client pkg do
    user 'root'
    group 'root'
    force true
    install_type 'cpan_module'
    action 'install'
  end
end


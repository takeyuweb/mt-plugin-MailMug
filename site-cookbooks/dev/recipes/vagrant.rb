#
# Cookbook Name:: dev
# Recipe:: vagrant
#
# Copyright 2014, Yuichi Takeuchi
#
# All rights reserved - Do Not Redistribute
#

# Vagrant によって
# /var/www/cgi-bin/mt/plugins
# /var/www/html/mt-static/plugins
# はrootで作成されるので権限調整

directory '/var/www/cgi-bin/mt' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

directory '/var/www/cgi-bin/mt/plugins' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

directory '/var/www/html' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

directory '/var/www/html/mt-static' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

directory '/var/www/html/mt-static/plugins' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

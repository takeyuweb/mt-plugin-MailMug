package 'unzip'
package 'rsync'
ark 'movabletype' do
  action :put
  path '/tmp/'
  url 'https://github.com/movabletype/movabletype/archive/master.zip'
  owner 'vagrant'
  group 'vagrant'
end

execute 'update movabletype' do
  group 'vagrant'
  user 'vagrant'
  cwd '/tmp'
  command <<-CMD
rsync -av --delete-after -exclude='mt-static/plugins/MailMug/' /tmp/movabletype/mt-static/* /var/www/html/mt-static
rm -rf /tmp/movabletype/mt-static
rsync -av --delete-after -exclude='plugins/MailMug/' /tmp/movabletype/* /var/www/cgi-bin/mt/
rm -rf /tmp/movabletype
  CMD
end

include_recipe 'database::mysql'
mysql_database 'movabletype' do
  connection(
      :host     => 'localhost',
      :username => 'root',
      :password => node['mysql']['server_root_password']
  )
  encoding 'utf8'
  action :create
end

cookbook_file 'movabletype.sql' do
  action :create
  path '/tmp/movabletype.sql'
end
execute 'import movabletype database' do
  group 'vagrant'
  user 'vagrant'
  cwd '/tmp'
  command 'mysql -u root movabletype < movabletype.sql'
  creates '/var/www/cgi-bin/mt/mt-config.cgi'
end

cookbook_file 'mt-config.cgi' do
  action :create
  path '/var/www/cgi-bin/mt/mt-config.cgi'
end

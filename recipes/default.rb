#
# Cookbook Name:: etherpad-lite
# Recipe:: default
#
# Copyright 2011, Steffen Gebert / TYPO3 Association
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "nodejs"
include_recipe "nodejs::npm"
include_recipe "git"


# Create etherpad-lite User
user "etherpad-lite" do
  shell "/bin/bash"
end

directory "/home/etherpad-lite" do
  owner "etherpad-lite"
  group"etherpad-lite"
end

packages = [
  'curl',
  'python',
  'libssl-dev',
]

packages.each do |pkg|
  package pkg
end

#################
# etherpad-lite

# Create directories
directory "/var/log/etherpad-lite" do
  owner "etherpad-lite"
  group "etherpad-lite"
  mode "755"
end

directory "/usr/local/etherpad-lite" do
  owner "etherpad-lite"
  group "etherpad-lite"
end

# installation of etherpad-lite
git "etherpad-lite" do
  user "etherpad-lite"
  group "etherpad-lite"
  repository node[:etherpadlite][:git][:repository]
  reference node[:etherpadlite][:git][:reference]
  destination "/usr/local/etherpad-lite"
  action :sync
  notifies :run, "execute[install_dependencies]", :immediately
  notifies :restart, "service[etherpad-lite]"
end

execute "install_dependencies" do
  command "bin/installDeps.sh"
  env "npm_config_cache" => "/home/etherpad-lite/.npm"
  cwd "/usr/local/etherpad-lite"
  user "etherpad-lite"
  group "etherpad-lite"
  action :nothing
end


############################
# etherpad-lite mysql setup

# Install MySQL server

include_recipe "database::mysql"
include_recipe "mysql::server"

# generate the password
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless[:etherpadlite][:database][:password] = secure_password

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node[:mysql][:server_root_password]}


mysql_database 'etherpadlite' do
  connection mysql_connection_info
  action :create
  notifies :create, "template[/usr/local/etherpad-lite/settings.json]"
end

# create etherpad-lite user
mysql_database_user 'etherpadlite' do
  connection mysql_connection_info
  password node[:etherpadlite][:database][:password]
  action :create
end

# Grant etherpad-lite
mysql_database_user 'etherpadlite' do
  connection mysql_connection_info
  password node[:etherpadlite][:database][:password]
  database_name 'etherpadlite'
  host 'localhost'
  privileges ["ALL PRIVILEGES"]
  action :grant
end


node.set_unless[:etherpadlite][:settings][:sessionkey] = secure_password
template "/usr/local/etherpad-lite/settings.json" do
  source "settings.json.erb"
  owner "etherpad-lite"
  group "etherpad-lite"
  mode "644"
  notifies :restart, "service[etherpad-lite]"
end

node.set_unless[:etherpadlite][:settings][:apikey] = secure_password
file "/usr/local/etherpad-lite/APIKEY.txt" do
  content node[:etherpadlite][:settings][:apikey]
end

# Install abiword package, if requested
package "abiword" do
  action :upgrade
  only_if { node[:etherpadlite][:settings][:abiword] }
end


# Install Init script
template "/etc/init.d/etherpad-lite" do
  source "etherpad-lite.init.erb"
  owner "root"
  group "root"
  mode "754"
end

service "etherpad-lite" do
  supports :status => true, :start => true, :stop => true
  action [ :start, :enable ]
end

# nginx reverse proxy
if node[:etherpadlite][:proxy][:enable]
  include_recipe "nginx"

  nginx_options = {}

  if node[:etherpadlite][:proxy][:ssl]
    package "ssl-cert"

    ssl_certfile_path = node[:etherpadlite][:proxy][:ssl_cert_path] || "/etc/ssl/certs/ssl-cert-snakeoil.pem"
    ssl_keyfile_path  = node[:etherpadlite][:proxy][:ssl_key_path]  ||"/etc/ssl/private/ssl-cert-snakeoil.key"
  end

  template "/etc/nginx/sites-available/#{node[:etherpadlite][:proxy][:hostname]}" do
    source "nginx-site.erb"
    notifies :restart, "service[nginx]"
    variables(
      :ssl_certfile => ssl_certfile_path,
      :ssl_keyfile  => ssl_keyfile_path
    )
    end

  nginx_site node[:etherpadlite][:proxy][:hostname] do
    enable true
  end

end


include_recipe "etherpad-lite::plugins"

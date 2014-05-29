
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "rbenv::rbenv_vars"

include_recipe "apache2"
include_recipe "build-essential"

rbenv_ruby "#{node['rails']['ruby_version']}" do
  ruby_version "#{node['rails']['ruby_version']}"
  global true
end 

rbenv_gem "bundler" do
  action :install
end

if platform?("centos","redhat")
  package "httpd-devel"
  if node['platform_version'].to_f < 6.0
    package 'curl-devel'
  else
    package 'libcurl-devel'
    package 'openssl-devel'
    package 'zlib-devel'
  end
else
  %w{ apache2-prefork-dev libapr1-dev libcurl4-gnutls-dev }.each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end

rbenv_gem "passenger" do
  action :install
end

rbenv_gem "rbenv-rehash" do
  action :install
end

rbenv_gem "rails_best_practices" do
  action :install
end



rbenv_execute "ruby_bin" do
  command 'rbenv which ruby > /tmp/ruby_bin'
end

rbenv_execute "passenger_root" do
  command 'passenger-config --root > /tmp/passenger_root'
end

ruby_block "set passenger attributes" do
  block do
    node.default[:passenger][:ruby_bin]    = %x(cat /tmp/ruby_bin).chomp
    node.default[:passenger][:root_path]   = %x(cat /tmp/passenger_root).chomp
    node.default[:passenger][:module_path] = "#{node[:passenger][:root_path]}/buildout/apache2/mod_passenger.so"
  end
end

if platform_family?('debian')
  template "#{node['apache']['dir']}/mods-available/passenger.load" do
    cookbook 'passenger_apache2'
    source 'passenger.load.erb'
    owner 'root'
    group 'root'
    mode 0644
  end
end

# Allows proper default path if root path was overridden
#node.default['passenger']['module_path'] = "#{node['passenger']['root_path']}/#{PassengerConfig.build_directory_for_version(node['passenger']['version'])}/apache2/mod_passenger.so"

template "#{node['apache']['dir']}/mods-available/passenger.conf" do
  cookbook 'passenger_apache2'
  source 'passenger.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end


rbenv_execute "passenger module" do
  command 'passenger-install-apache2-module --auto'
  creates node[:passenger][:module_path]
end

apache_module 'passenger' do
  module_path node['passenger']['module_path']
end

#include_recipe 'passenger_apache2::mod_rails'


rbenv_gem "pry" do
  action :install
end

rbenv_gem "rails" do
  action :install
end

%w(libsqlite3-dev).each do |pkg|
  package pkg do
    action :install
  end
end


rbenv_execute 'bundle install' do
  cwd "/home/vagrant/app/#{node['rails']['app_name']}"
  command "bundle install"
end
rbenv_execute 'rake db:reset' do
  cwd "/home/vagrant/app/#{node['rails']['app_name']}"
  command "rake db:reset RAILS_ENV=test"
end
rbenv_execute 'rake db:migrate' do
  cwd "/home/vagrant/app/#{node['rails']['app_name']}"
  command "rake db:migrate RAILS_ENV=test"
end



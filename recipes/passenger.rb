%w{openssl-devel readline-devel zlib-devel curl-devel
   libyaml-devel httpd httpd-devel apr-devel apr-util-devel}.each do |p|
  package p do
    action :install
  end
end

gem_package "passenger" do
  action :install
end

execute "passenger.install" do
  command "passenger-install-apache2-module --auto"
  action :run
end

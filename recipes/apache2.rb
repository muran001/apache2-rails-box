#template "#{node['apache']['dir']}/sites-available/rails" do
#  source 'rails.erb'
#  group 'root'
#  owner 'root'
#  mode '0644'
#  if ::File.exists?("#{node['apache']['dir']}/sites-enabled/rails")
#    notifies :reload, 'service[apache2]'
#  end
#end
#
#
#apache_site 'rails' do
#  enable true
#end


web_app 'rails' do
  server_name "#{node['rails']['server_name']}"
  server_aliases ["www.#{node['rails']['server_name']}"]
  docroot "/home/vagrant/app/#{node['rails']['app_name']}/public"
end


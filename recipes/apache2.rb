template '/etc/apache2/sites-available/rails' do
  source 'rails.erb'
  group 'root'
  owner 'root'
  mode '0644'
end


apache_site 'rails' do
  enable true
end



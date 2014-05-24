
service 'mysql' do
  supports status: true, restart: true, reload: true
  action [ :enable, :start ]
end

template '/etc/mysql/conf.d/rails_db.cnf' do
  source 'rails_db.cnf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  if ::File.exists?("/etc/mysql/conf.d/rails_db.cnf")
    notifies :restart, 'service[mysql]', :immediately
  end

end


mysql_connection_info = {
  host: "localhost",
  username: "root",
  password: node['mysql']['server_root_password']
}

mysql_database node['rails']['db_name'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['rails']['db_admin'] do
  connection mysql_connection_info
  password node['rails']['db_admin_pass']
  database_name node['rails']['db_name']
  privileges [:all]
  action [:create, :grant]

end

mysql_database_user node['rails']['db_app_user'] do
  connection mysql_connection_info
  password node['rails']['db_app_user_pass']
  database_name node['rails']['db_name']
  privileges [:select, :update, :insert, :delete, :create, :index, :drop]
  action [:create, :grant]
end



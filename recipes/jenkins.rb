include_recipe 'jenkins::master'

jenkins_plugin 'git'
jenkins_plugin 'rbenv'
jenkins_plugin 'greenballs'
jenkins_plugin 'plot'

jenkins_dir = '/home/vagrant/jenkins'

directory jenkins_dir do
  action :create
end

#template "#{jenkins_dir}/plot-rspec-slowest-examples.rb" do
#  source 'plot-rspec-slowest-examples.rb.erb'
#end

rails_job_config = File.join(Chef::Config[:file_cache_path], "#{node['rails']['job_name']}.xml")

template rails_job_config do
  source 'jenkins_config.xml.erb'
end

jenkins_job node['rails']['job_name'] do
  config rails_job_config
end

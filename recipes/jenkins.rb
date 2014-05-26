include_recipe 'jenkins::master'

template rails_job do
  source 'jenkins-config.xml.erb'
end

jenkins_job 'rails_app' do
  config rails_job
end

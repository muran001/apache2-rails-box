
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

include_recipe "rbenv::rbenv_vars"

rbenv_ruby "2.1.1" do
  ruby_version "2.1.1"
  global true
end 

rbenv_gem "bundler" do
  ruby_version "2.1.1"
end

rbenv_gem "passenger" do
  action :install
end

rbenv_gem "rbenv-rehash" do
  action :install
end

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


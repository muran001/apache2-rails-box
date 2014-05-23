# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "apache2-rails-box"

  config.omnibus.chef_version = :latest

  config.vm.box = "precise64"

  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :private_network, ip: "192.168.33.10"

  config.berkshelf.enabled = true

  #config.vm.synced_folder '../app', '/home/vagrant/app', nfs: true


  config.vm.provision :chef_solo do |chef|
    chef.json = {
      mysql: {
        server_root_password: 'rootpass',
        server_debian_password: 'debpass',
        server_repl_password: 'replpass'
      },
      tz: "Asia/Tokyo",
      apache: {
        doc_root: '/home/vagrant/app'
      }
    }

    chef.run_list = [
        "recipe[apt]",
        "recipe[build-essential]",
        "recipe[vim::default]",
        "recipe[git::default]",
        "recipe[apache2-rails-box::apache2]",
        "recipe[apache2::default]",
        "recipe[passenger_apache2::mod_rails]",
        "recipe[mysql::server]",
        "recipe[ruby_build]",
        "recipe[rbenv::default]",
        "recipe[timezone::default]",
        "recipe[jenkins::master]",
        "recipe[apache2-rails-box::rails]"
    ]
  end
end

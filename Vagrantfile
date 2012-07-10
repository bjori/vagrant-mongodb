# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 :

require './vagrant-mongo/lib/vagrant_init.rb'

Vagrant::Config.run do |config|

  config.vm.box = "replicaset"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "replicaset.pp"
    puppet.module_path    = "puppet/modules"
  end

  config.mongo.rs       = "RS"
  config.mongo.auth     = "random string"

  config.vm.define :primary do |primary|
    primary.vm.network :hostonly, "172.16.1.10"
    primary.vm.host_name = "primary.rs.local"

    primary.mongo.id       = 0
    primary.mongo.priority = 20

  end

  config.vm.define :secondary do |secondary|
    secondary.vm.network :hostonly, "172.16.1.11"
    secondary.vm.host_name = "secondary.rs.local"

    secondary.mongo.id       = 1
    secondary.mongo.priority = 10
  end


  config.vm.define :tertiary do |tertiary|
    tertiary.vm.network :hostonly, "172.16.1.12"
    tertiary.vm.host_name = "tertiary.rs.local"

    tertiary.mongo.id      = 2
    tertiary.mongo.arbiter = true
  end


  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

end

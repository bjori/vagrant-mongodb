# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 :

require './vagrant-mongo/lib/vagrant_init.rb'

Vagrant::Config.run do |config|

### World wide configure

  # Which base box to use, or fetch if not present
  config.vm.box = "replicaset"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  # Use puppet, and the replicaset.pp manifest
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "replicaset.pp"
    puppet.module_path    = "puppet/modules"
  end

  # The ReplicaSet name, and content of the keyfile if we want auth
  config.mongo.rs       = "RS"
  config.mongo.auth     = "random string"


### Per-server configuration
  config.vm.define :primary do |primary|
    # Configure the hostname and IP
    # You should probably update your local /etc/hosts with this info
    primary.vm.network :hostonly, "172.16.1.10"
    primary.vm.host_name = "primary.rs.local"

    # ReplicaSet config entry ID
    primary.mongo.id       = 0
    # The priority of this member to become primary
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
    # Make this one arbiter
    tertiary.mongo.arbiter = true
  end

end


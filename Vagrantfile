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


### Per-server configuration
  config.vm.define :primaryauth do |primaryauth|
    # Configure the hostname and IP
    # You should probably update your local /etc/hosts with this info
    primaryauth.vm.network :hostonly, "172.16.1.10"
    primaryauth.vm.host_name = "primaryauth.rs.local"

    # The ReplicaSet name, and content of the keyfile if we want auth
    primaryauth.mongo.rs       = "RSAuth"
    primaryauth.mongo.auth     = "random string"

    # ReplicaSet config entry ID
    primaryauth.mongo.id       = 0
    # The priority of this member to become primaryauth
    primaryauth.mongo.priority = 20

  end

  config.vm.define :secondaryauth do |secondaryauth|
    secondaryauth.vm.network :hostonly, "172.16.1.11"
    secondaryauth.vm.host_name = "secondaryauth.rs.local"

    secondaryauth.mongo.rs       = "RSAuth"
    secondaryauth.mongo.auth     = "random string"

    secondaryauth.mongo.id       = 1
    secondaryauth.mongo.priority = 10
  end

  config.vm.define :tertiaryauth do |tertiaryauth|
    tertiaryauth.vm.network :hostonly, "172.16.1.12"
    tertiaryauth.vm.host_name = "tertiaryauth.rs.local"

    tertiaryauth.mongo.rs       = "RSAuth"
    tertiaryauth.mongo.auth     = "random string"

    tertiaryauth.mongo.id      = 2
    # Make this one arbiter
    tertiaryauth.mongo.arbiter = true
  end


  config.vm.define :standaloneauth do |standaloneauth|
    standaloneauth.vm.network :hostonly, "172.16.2.10"
    standaloneauth.vm.host_name = "standaloneauth.local"

    standaloneauth.mongo.auth     = "true"
    standaloneauth.mongo.id       = 42
  end


### And now without authentication
  config.vm.define :primary do |primary|
    primary.vm.network :hostonly, "172.16.3.10"
    primary.vm.host_name = "primary.rs.local"

    primary.mongo.rs       = "RS"

    primary.mongo.id       = 0
    primary.mongo.priority = 20

  end

  config.vm.define :secondary do |secondary|
    secondary.vm.network :hostonly, "172.16.3.11"
    secondary.vm.host_name = "secondary.rs.local"

    secondary.mongo.rs       = "RS"

    secondary.mongo.id       = 1
    secondary.mongo.priority = 10
  end

  config.vm.define :tertiary do |tertiary|
    tertiary.vm.network :hostonly, "172.16.3.12"
    tertiary.vm.host_name = "tertiary.rs.local"

    tertiary.mongo.rs       = "RS"

    tertiary.mongo.id      = 2
    tertiary.mongo.arbiter = true
  end


  config.vm.define :standalone do |standalone|
    standalone.vm.network :hostonly, "172.16.4.10"
    standalone.vm.host_name = "standalone.local"

    standalone.mongo.id       = 42
  end


end


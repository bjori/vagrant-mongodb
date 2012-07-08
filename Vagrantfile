# -*- mode: ruby -*-
# vi: set ft=ruby :

require './vagrant-mongo/lib/vagrant_init.rb'

Vagrant::Config.run do |config|

    config.vm.define :primary do |primary|
        primary.vm.box = "replicaset"
        primary.vm.box_url = "http://files.vagrantup.com/lucid64.box"

        primary.vm.network :hostonly, "172.16.1.10"
        primary.vm.host_name = "primary.rs.local"

        primary.vm.provision :puppet do |puppet|
            puppet.manifests_path = "manifests"
            puppet.manifest_file  = "replicaset.pp"
            puppet.module_path    = "modules"
        end

        primary.mongo.id       = 0
        primary.mongo.priority = 20
    end

    config.vm.define :secondary do |secondary|
        secondary.vm.box = "replicaset"
        secondary.vm.box_url = "http://files.vagrantup.com/lucid64.box"

        secondary.vm.network :hostonly, "172.16.1.11"
        secondary.vm.host_name = "secondary.rs.local"

        secondary.vm.provision :puppet do |puppet|
            puppet.manifests_path = "manifests"
            puppet.manifest_file  = "replicaset.pp"
            puppet.module_path    = "modules"
        end

        secondary.mongo.id       = 1
        secondary.mongo.priority = 10
  end


  config.vm.define :tertiary do |tertiary|
      tertiary.vm.box = "replicaset"
      tertiary.vm.box_url = "http://files.vagrantup.com/lucid64.box"

      tertiary.vm.network :hostonly, "172.16.1.12"
      tertiary.vm.host_name = "tertiary.rs.local"

      tertiary.vm.provision :puppet do |puppet|
          puppet.manifests_path = "manifests"
          puppet.manifest_file  = "replicaset.arbiter.pp"
          puppet.module_path    = "modules"
      end

      tertiary.mongo.id      = 2
      tertiary.mongo.arbiter = true
  end


  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

end

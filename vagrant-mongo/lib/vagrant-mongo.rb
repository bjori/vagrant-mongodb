require 'vagrant'
require File.dirname(__FILE__) + '/vagrant-mongo/middleware'
require File.dirname(__FILE__) + '/vagrant-mongo/config'
require File.dirname(__FILE__) + '/vagrant-mongo/configure'
require File.dirname(__FILE__) + '/vagrant-mongo/command'


Vagrant.config_keys.register(:mongo) { VagrantMongo::Config }

# We need this to be executed after the entire environment is up and running
#Vagrant.actions[:start].insert_before Vagrant::Action::VM::Provision, VagrantMongo::Middleware::ReplicaSet

Vagrant.commands.register(:mongo) { VagrantMongo::Command::Mongo }

#I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)

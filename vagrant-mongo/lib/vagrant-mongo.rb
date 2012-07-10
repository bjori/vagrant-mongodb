require 'vagrant'
require File.dirname(__FILE__) + '/vagrant-mongo/middleware'
require File.dirname(__FILE__) + '/vagrant-mongo/facter'
require File.dirname(__FILE__) + '/vagrant-mongo/config'
require File.dirname(__FILE__) + '/vagrant-mongo/configure'
require File.dirname(__FILE__) + '/vagrant-mongo/command'


Vagrant.config_keys.register(:mongo) { VagrantMongo::Config }

# We need this to be executed after the entire environment is up and running
#Vagrant.actions[:start].insert_before Vagrant::Action::VM::Provision, VagrantMongo::Middleware::ReplicaSet

# This will inject a 'fact' with the ReplicaSet name so we can pass the apropriate arguments to mongod
#Vagrant.actions[:start].insert_after Vagrant::Action::VM::Provision, VagrantMongo::Middleware::Facter
Vagrant.actions[:provision].insert_before Vagrant::Action::VM::Provision, VagrantMongo::Middleware::Facter
Vagrant.actions[:start].insert_after Vagrant::Action::VM::Provision, VagrantMongo::Middleware::Facter

Vagrant.commands.register(:mongo) { VagrantMongo::Command::Mongo }

#I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)

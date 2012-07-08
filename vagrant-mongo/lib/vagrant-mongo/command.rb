require 'optparse'

module VagrantMongo

  module Command
    class Mongo < Vagrant::Command::Base

      def execute
        options = {}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: vagrant mongo vm-name --init-replicaset"

          opts.separator ""

          opts.on("", "--init-replicaset", "Initialize or reconfigure replicaset") do |c|
            options[:replicaset] = c
          end
        end

        argv = parse_options(opts)
        return if !argv


        raise Vagrant::Errors::CLIInvalidOptions, :help => opts.help.chomp if argv.empty?
          #with_target_vms(nil) { |vm| execute_on_primary_vm(vm) }
        #else
          argv.each do |vm_name|
            with_target_vms(vm_name) do  |vm|
              if options[:replicaset]
                execute_on_vm(vm)
              end
            end
          end
        #end
      end

      def execute_on_vm(vm)
        opts = vm.config.mongo.to_hash
        VagrantMongo::Configure.new(@env, vm, opts).run
      end

      def execute_on_primary_vm(vm)
        return if vm.config.mongo.arbiter
        primary = vm.config.vm.host_name;
        pr = 0

        @env.vms.each do |name, subvm|
          if subvm.config.mongo.arbiter != true
            if subvm.config.mongo.priority > pr
              pr = subvm.config.mongo.priority
              primary = subvm.config.vm.host_name
            end
          end
        end

        # In case two or more have the same priority
        execute_on_vm(vm) if vm.config.vm.host_name == primary
      end

    end
  end
end

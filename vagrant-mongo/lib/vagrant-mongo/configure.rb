require 'json'
module VagrantMongo

  class Configure

    def initialize(env, vm, options = {})
      @env = env
      @vm = vm
      @options = options
    end

    def run
      raise Vagrant::Errors::VMNotCreatedError if !@vm.created?
      raise Vagrant::Errors::VMInaccessible if !@vm.state == :inaccessible
      raise Vagrant::Errors::VMNotRunningError if @vm.state != :running


      cfg = make_cfg(@options)

      reconfig_rs(cfg) if replicaset_initialized?
      init_replicaset(cfg) unless replicaset_initialized?
    end

    def make_cfg(options)
      members = []
      @env.vms.each do |name, subvm|
        member = {}
        if subvm.config.mongo
          c = subvm.config.mongo.to_hash
          member[:_id] = c[:rs][:id]
          member[:host] = subvm.config.vm.host_name

          if subvm.config.mongo.priority
            member[:priority] = subvm.config.mongo.priority
          end
          if subvm.config.mongo.arbiter
            member[:arbiterOnly] = true
          end
        end
        members.push(member)
      end
      retval = { :_id => "RS", :members => members }

      retval
    end

    def reconfig_rs(cfg)
      return unless is_master?
      json = cfg.to_json

      @vm.channel.execute("mongo --eval 'rs.reconfig(#{json}).errmsg'") do |type, data|
        @vm.ui.info(data, :prefix => false, :new_line => false)
      end

    end

    def replicaset_initialized?
      @vm.channel.execute("mongo --eval 'rs.status().ok' | tail -n1", :error_check => false) do | type, data |
        return data.chomp == "1"
      end
    end

    def init_replicaset(cfg)
      json = cfg.to_json

      @vm.channel.execute("mongo --eval 'rs.initiate(#{json}).errmsg'") do |type, data|
        @vm.ui.info(data, :prefix => false, :new_line => false)
      end

    end

    def is_master?
      @vm.channel.execute("mongo --eval 'rs.isMaster().ismaster' | tail -n1") do |type, data|
        return data.chomp == "true"
      end
    end

  end

end

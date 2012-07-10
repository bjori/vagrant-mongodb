module VagrantMongo
  module Middleware

    class Facter
      def initialize(app, env)
        @app = app
        @env = env
        @vm  = env[:vm]
      end

      def call(env)

        options = @vm.config.mongo.to_hash
        puts options

        @env[:vm].config.vm.provisioners.each do |provisioner|
          if provisioner.shortcut.to_s == "puppet"
            if options[:rs][:name]
              provisioner.config.facter[:rs_name] = options[:rs][:name]

              provisioner.config.facter[:rs_arbiter] = options[:rs][:arbiter] ? "true" : "false"
            end

            provisioner.config.facter[:mongo_auth] = options[:auth]

          end
        end

        @app.call(env)

      end

    end
  end
end

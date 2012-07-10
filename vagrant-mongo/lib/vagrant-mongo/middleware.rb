module VagrantMongo
  module Middleware

    class ReplicaSet
      def initialize(app, env)
        @app = app
        @env = env
        @vm  = env[:vm]
      end

      def call(env)
        @app.call(env)

        options = @vm.config.mongo.to_hash
        VagrantMongo::Configure.new(@vm.env, @vm, options).initReplicaset
      end

    end
  end
end

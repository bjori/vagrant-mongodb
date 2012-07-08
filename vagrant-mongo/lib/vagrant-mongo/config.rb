module VagrantMongo

  class Config < Vagrant::Config::Base
    attr_accessor :id
    attr_accessor :priority
    attr_accessor :arbiter


    def to_hash
        {
            :rs => {
                :id => id,
                :priority => priority
            },
            :arbiter => arbiter
        }
    end


    def validate(env, errors)
    end
  end
end

module VagrantMongo

  class Config < Vagrant::Config::Base
    attr_accessor :id
    attr_accessor :priority
    attr_accessor :arbiter
    attr_accessor :rs
    attr_accessor :auth


    def to_hash
        {
            :rs => {
                :id => id,
                :priority => priority,
                :name => rs,
                :arbiter => arbiter
            },
            :auth => auth
        }
    end


    def validate(env, errors)
    end
  end
end

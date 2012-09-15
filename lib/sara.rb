require "sara/version"

module Sara
  def self.included(mod)
    mod.extend(ClassMethods)
  end

  module ClassMethods
    def method_missing(method_name, *args, &block)
      if method_name =~ /(list|on|trigger)_([a-z]+)/
        send($1, $2, *args, &block)
      else
        super
      end
    end

    private

    def callbacks
      @callbacks ||= Hash.new do |hash, key|
        hash[key] = []
      end
    end

    def list(type)
      callbacks[type]
    end

    def on(type, &block)
      callbacks[type] << block
    end

    def trigger(type, *args)
      callbacks[type].each do |callback|
        callback.call(*args)
      end
    end
  end
end

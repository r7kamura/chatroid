class Chatroid
  module Callback
    # You can call methods like this:
    # * list_message    : return Array of callbacks for "message"
    # * on_message      : store a given block as callback for "message"
    # * trigger_message : trigger callbacks for "message" with given args
    def method_missing(method_name, *args, &block)
      if method_name =~ /(list|on|trigger)_([a-z0-9]+)/
        send($1, $2, *args, &block)
      else
        super
      end
    end

    private

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

    def callbacks
      @callbacks ||= Hash.new do |hash, key|
        hash[key] = []
      end
    end
  end
end

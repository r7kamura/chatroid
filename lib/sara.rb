require "sara/version"

module Sara
  module ClassMethods
    def on_message(&block)
      on_messages << block
    end

    def on_messages
      @on_messages ||= []
    end

    def do_message(message)
      on_messages.each do |callback|
        callback.call(message)
      end
    end
  end

  def self.included(mod)
    mod.extend(ClassMethods)
  end
end

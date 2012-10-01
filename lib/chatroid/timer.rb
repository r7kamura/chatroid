require "chatroid/timer/event"

class Chatroid
  module Timer
    def on_time(every, &block)
      events << Event.new(every, &block)
    end

    private

    def start_timer
      Thread.new do
        loop do
          events.each(&:call)
          sleep 1
        end
      end
    end

    def events
      @events ||= []
    end
  end
end

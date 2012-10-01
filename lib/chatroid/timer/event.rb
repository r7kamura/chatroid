class Chatroid
  module Timer
    class Event
      # `every` is a Hash object which may have following keys:
      # :sec
      # :min
      # :hour
      #
      # `block` will be executed at times specified by `every`
      #
      # Example: "Hello, world!" will be printed at 14:00 and 14:30 every day
      # event = Event.new(:hour => 14, :min => [0, 30], :sec => 0) do
      #   foo
      # end
      #
      # loop do
      #   event.call
      #   sleep 1
      # end

      UNITS = [
        :sec,
        :min,
        :hour,
        :day,
        :wday,
        :month,
      ].freeze

      def initialize(every, &block)
        @every = every
        @block = block
      end

      def call
        @block.call if available?
      end

      private

      def available?
        now = Time.now
        UNITS.all? do |unit|
          if @every[unit]
            conditions = Array(@every[unit])
            conditions.any? { |condition| condition == now.send(unit) }
          else
            true
          end
        end
      end
    end
  end
end

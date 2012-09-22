require "zircon"

class Chatroid
  module Adapter
    module Irc
      private

      def connect
        observe
        client.run!
      end

      def client
        @client ||= Zircon.new(
          :server   => config[:server],
          :port     => config[:port],
          :channel  => config[:channel],
          :password => config[:password],
          :username => config[:username],
          :nickname => config[:nickname],
          :realname => config[:realname]
        )
      end

      def observe
        client.on_message do |message|
          send("trigger_#{message.type}", message)
        end
      end

      Zircon::COMMAND_NAMES.each do |name|
        define_method(name.downcase) do |*args|
          client.send(name.downcase, *args)
        end
      end
    end
  end
end

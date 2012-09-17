require "avalon"
require "xmpp4r"
require "xmpp4r/muc/helper/simplemucclient"
require "logger"

class Chatroid
  module Adapter
    module HipChat
      REQUIRED_CONFIG_KEYS = [
        :jid,
        :room,
        :nick,
        :password,
      ].freeze

      def self.extended(chatroid)
        REQUIRED_CONFIG_KEYS.each do |key|
          Avalon.validate(chatroid.config[key], String)
        end
      end

      private

      def post(body)
        message = Jabber::Message.new(config[:room], body)
        room.send(message)
      end

      def connect
        use_logger
        room.on_message { |*args| trigger_message(*args) }
        room.join(room_key)
        persist
      end

      def persist
        trap(:INT) { exit }
        loop { sleep 1 }
      end

      def client
        @client ||= begin
          jabber_client = Jabber::Client.new(config[:jid])
          jabber_client.connect
          jabber_client.auth(config[:password])
          jabber_client
        end
      end

      def room
        @room ||= Jabber::MUC::SimpleMUCClient.new(client)
      end

      def room_key
        config[:room] + "/" + config[:nick]
      end

      def use_logger
        if config[:logger]
          Jabber.logger = config[:logger]
          Jabber.debug  = true
        end
      end
    end
  end
end

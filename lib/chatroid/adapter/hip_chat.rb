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

      EVENT_NAMES = [
        :join,
        :leave,
        :message,
        :private_message,
        :room_message,
        :self_leave,
        :subject,
      ].freeze

      def self.extended(chatroid)
        REQUIRED_CONFIG_KEYS.each do |key|
          Avalon.validate(chatroid.config[key], String)
        end
      end

      private

      def post(text)
        room.say(text)
      end

      def connect
        use_logger
        bind_callbacks
        join_room
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

      def join_room
        room.join(room_key)
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

      def bind_callbacks
        EVENT_NAMES.each do |name|
          room.__send__("on_#{name}") do |*args|
            __send__("trigger_#{name}", *args)
          end
        end
      end
    end
  end
end

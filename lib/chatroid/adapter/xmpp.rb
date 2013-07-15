require "avalon"
require "xmpp4r"
require "xmpp4r/muc/helper/simplemucclient"
require "logger"
require "rexml/source"

# Support multybyte characters.
class REXML::IOSource
  def read
    @buffer << readline.force_encoding("utf-8")
  rescue Exception, NameError
    @source = nil
  end
end

class Chatroid
  module Adapter
    module Xmpp
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

      SLEEP_INTERVAL_SEC = 1

      def self.extended(chatroid)
        REQUIRED_CONFIG_KEYS.each do |key|
          Avalon.validate(chatroid.config[key], String)
        end
      end

      def say(text)
        room.say(text)
      end

      def invite(jid, reason = nil)
        room.invite(jid => reason)
      end

      def kick(nick, reason = nil)
        room.kick(nick, reason)
      end

      def ban(jid, reason = nil)
        room.ban(jid, reason)
      end

      def unban(jid)
        room.unban(jid)
      end

      def promote(nick)
        room.prompt(nick)
      end

      def demote(nick)
        room.demote(nick)
      end

      def join(jid, password = nil)
        room.join(jid, password)
      end

      def exit(reason = nil)
        room.exit(reason)
      end

      def subject=(text)
        room.subject = text
      end

      def subject
        room.subject
      end

      def nick
        room.nick
      end

      private

      def connect
        use_logger
        bind_callbacks
        join_room
        persist
      end

      def persist
        trap(:INT) { Kernel.exit }
        loop { sleep SLEEP_INTERVAL_SEC }
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

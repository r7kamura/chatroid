require "tinder"

class Chatroid
  module Adapter
    module Campfire
      private

      def connect
        observe
      end

      def client
        @client ||= Tinder::Campfire.new(
          config[:subdomain],
          :token => config[:token]
        )
      end

      def room
        @room ||=
          if config[:room_id]
            client.find_room_by_id(config[:room_id])
          elsif config[:room_name]
            client.find_room_by_name(config[:room_name])
          else
            raise ArgumentError.new("Missing required config: room_id or room_name")
          end
      end

      def observe
        room.listen do |message|
          case message.type
          when 'TextMessage', 'PasteMessage', 'SoundMessage'
            trigger_message(message)
          end
        end
      end

      def speak(message)
        room.speak(message)
      end

      def paste(message)
        room.paste(message)
      end

      def play(sound)
        room.play(sound)
      end

      def tweet(url)
        room.tweet(url)
      end

      def user_info
        @info ||= client.me
      end
    end
  end
end

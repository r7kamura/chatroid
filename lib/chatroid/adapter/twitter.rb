require "twitter/json_stream"
require "twitter_oauth"
require "json"

class Chatroid
  module Adapter
    module Twitter
      private

      def connect
        EventMachine::run do
          stream.each_item do |json|
            event = JSON.parse(json)
            on_each_event(event)
          end
        end
      end

      def stream
        @stream ||= ::Twitter::JSONStream.connect(
          :host  => "userstream.twitter.com",
          :path  => "/2/user.json",
          :port  => 443,
          :ssl   => true,
          :oauth => {
            :consumer_key    => config[:consumer_key],
            :consumer_secret => config[:consumer_secret],
            :access_key      => config[:access_key],
            :access_secret   => config[:access_secret],
          }
        )
      end

      def client
        @client ||= TwitterOAuth::Client.new(
          :consumer_key    => config[:consumer_key],
          :consumer_secret => config[:consumer_secret],
          :token           => config[:access_key],
          :secret          => config[:access_secret]
        )
      end

      def tweet(body)
        client.update(body)
      end

      def reply(body, event)
        id   = event["id"]
        user = event["user"]["screen_name"]
        body = "@#{user} #{body}"
        client.update(body, :in_reply_to_status_id => id)
      end

      def favorite(event)
        client.favorite(event["id"])
      end

      def user_info
        @user_info ||= client.info
      end

      def on_each_event(event)
        case
        when event["in_reply_to_user_id"] == user_info["id"]
          trigger_reply(event)
        when event["text"]
          trigger_tweet(event)
        end
      end
    end
  end
end

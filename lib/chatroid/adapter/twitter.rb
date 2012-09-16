require "twitter/json_stream"

class Chatroid
  module Adapter
    class Twitter
      def initialize(chatroid)
        @chatroid = chatroid
      end

      def connect
        EventMachine::run do
          stream.each_item(&method(:on_each_event))
        end
      end

      def post(body, options = {})
        client.update(body)
      end

      def user_info
        @user_info ||= @client.info
      end

      private

      def stream
        @stream ||= ::Twitter::JSONStream.connect(
          :host  => "userstream.twitter.com",
          :path  => "/2/user.json",
          :port  => 443,
          :ssl   => true,
          :oauth => {
            :consumer_key    => @chatroid.config[:consumer_key],
            :consumer_secret => @chatroid.config[:consumer_secret],
            :access_key      => @chatroid.config[:access_key],
            :access_secret   => @chatroid.config[:access_secret],
          }
        )
      end

      def client
        @client ||= TwitterOAuth::Client.new(
          :consumer_key    => @chatroid.config[:consumer_key],
          :consumer_secret => @chatroid.config[:consumer_secret],
          :token           => @chatroid.config[:access_key],
          :secret          => @chatroid.config[:access_secret]
        )
      end

      def on_each_event(event)
        case
        when event["in_reply_to_id"]
          on_reply(event)
        when event["text"]
          on_tweet(event)
        end
      end

      def on_tweet(event)
        @chatroid.trigger_tweet(event)
      end

      def on_reply(event)
        @chatroid.trigger_reply(event)
      end
    end
  end
end

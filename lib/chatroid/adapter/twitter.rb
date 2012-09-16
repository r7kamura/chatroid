require "twitter/json_stream"

class Chatroid
  module Adapter
    class Twitter
      def initialize(chatroid)
        @chatroid = chatroid
      end

      def connect
        EventMachine::run do
          stream.each_item(&method(:on_each_item))
        end
      end

      def post(body, options = {})
        client.update(body)
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

      def on_each_item(item)
        case
        when item["in_reply_to_id"]
          on_reply(item)
        when item["text"]
          on_tweet(item)
        end
      end

      def on_tweet(item)
        @chatroid.trigger_tweet(item)
      end

      def on_reply(item)
        @chatroid.trigger_reply(item)
      end
    end
  end
end

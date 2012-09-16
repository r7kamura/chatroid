require "twitter/json_stream"

class Chatroid
  module Adapter
    class Twitter
      def initialize(chatroid)
        @chatroid = chatroid
      end

      def connect
        EventMachine::run do
          stream = ::Twitter::JSONStream.connect(config)
          stream.each_item(&method(:on_message))
        end
      rescue EventMachine::ConnectionError => e
        p e
      end

      private

      def config
        {
          :host  => "userstream.twitter.com",
          :path  => "/2/user.json",
          :port  => 443,
          :ssl   => true,
          :oauth => {
            :consumer_key    => "",
            :consumer_secret => "",
            :access_key      => "",
            :access_secret   => "",
          },
        }
      end

      def on_message(item)
        @chatroid.trigger_message(item.text)
      end
    end
  end
end

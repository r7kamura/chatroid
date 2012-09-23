require "chatroid/adapter/twitter/event"
require "twitter/json_stream"
require "twitter_oauth"
require "json"
require "cgi"

class Chatroid
  module Adapter
    module Twitter
      private

      def connect
        EventMachine::run do
          stream.on_error &method(:on_error)
          stream.each_item &method(:on_each_item)
        end
      end

      def stream
        @stream ||= ::Twitter::JSONStream.connect(
          :host  => host,
          :path  => path,
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

      def follow(event)
        client.friend(event["user"]["id"])
      end

      def user_info
        @user_info ||= client.info
      end

      def on_each_item(json)
        event = Event.new(json, user_info["id"])
        send("trigger_#{event.type}", event.params)
      end

      def on_error(error)
        p error
        exit
      end

      def host
        config[:filter] ?
          "stream.twitter.com" :
          "userstream.twitter.com"
      end

      def path
        config[:filter] ?
          "/1.1/statuses/filter.json?track=#{CGI.escape(config[:filter])}" :
          "/1.1/user.json"
      end
    end
  end
end

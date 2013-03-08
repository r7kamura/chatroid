require "json"

class Chatroid
  module Adapter
    module Twitter
      class Event
        TYPES = %w[
          favorite
          unfavorite
          follow
          unfollow
          list_member_added
          list_member_removed
          list_user_subscribed
          list_user_unsubscribed
        ].freeze

        attr_reader :params

        def initialize(json, user_id)
          @params  = JSON.parse(json)
          @user_id = user_id
        end

        def type
          if has_event_type? && targeted_to_me?
            @params["event"]
          elsif reply_to_me?
            "reply"
          elsif tweet?
            "tweet"
          elsif favorite?
            "favorite_other"
          else
            "unknown"
          end
        end

        private

        def targeted_to_me?
          @params["target"] && @params["target"]["id"] == @user_id
        end

        def has_event_type?
          @params["event"] && TYPES.include?(@params["event"])
        end

        def reply_to_me?
          @params["in_reply_to_user_id"] && @params["in_reply_to_user_id"] == @user_id
        end

        def tweet?
          @params["text"]
        end

        def favorite?
          @params["event"] == "favorite"
        end
      end
    end
  end
end

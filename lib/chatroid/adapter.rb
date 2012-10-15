require "chatroid/adapter/campfire"
require "chatroid/adapter/irc"
require "chatroid/adapter/twitter"
require "chatroid/adapter/xmpp"

class Chatroid
  module Adapter
    def self.find(service_name)
      const_get(service_name)
    rescue NameError
      nil
    end
  end
end

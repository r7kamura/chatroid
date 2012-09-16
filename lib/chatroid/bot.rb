require "chatroid/bot/callback"
require "chatroid/bot/adapter"
require "hashie"

module Chatroid
  class Bot
    include Callback

    attr_reader :config

    def initialize(config = {})
      configure(config)
    end

    def configure(config)
      @config = Hashie::Mash.new(config)
    end

    def connect
      validate_connection
      adapter_class.new(config).connect
    end

    private

    def validate_connection
      validate_config
      validate_adapter
    end

    def validate_config
      unless has_service?
        raise ConnectionError.new("config.service is not configured")
      end
    end

    def validate_adapter
      unless has_adapter?
        raise ConnectionError.new("#{@config.service} is not supported")
      end
    end

    def has_service?
      @config.service?
    end

    def has_adapter?
      has_service? && adapter_class
    end

    def adapter_class
      Adapter.find(@config.service)
    end

    class ConnectionError < StandardError; end
  end
end

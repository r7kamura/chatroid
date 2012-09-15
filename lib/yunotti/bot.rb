require "yunotti/bot/callback"
require "hashie"

module Yunotti
  class Bot
    include Callback

    attr_reader :config

    def initialize(config = {})
      configure(config)
    end

    def configure(config)
      @config = Hashie::Mash.new(config)
    end
  end
end

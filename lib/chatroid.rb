require "chatroid/version"
require "chatroid/callback"
require "chatroid/timer"
require "chatroid/adapter"

class Chatroid
  include Callback
  include Timer

  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def config
    @config ||= {}
  end

  def run!
    Thread.abort_on_exception = true
    validate_connection
    extend(adapter)
    start_timer unless events.empty?
    connect
  end

  private

  # Utility method for configure
  def set(*args)
    case args.size
    when 1
      configure(args[0])
    when 2
      configure(args[0] => args[1])
    else
      raise ArgumentError
    end
  end

  def configure(hash)
    config.merge!(hash)
  end

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
      raise ConnectionError.new("#{config[:service]} is not supported")
    end
  end

  def has_service?
    config[:service]
  end

  def has_adapter?
    has_service? && adapter
  end

  def adapter
    Adapter.find(config[:service])
  end

  class ConnectionError < StandardError; end
end

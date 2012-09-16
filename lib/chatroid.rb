require "chatroid/version"
require "chatroid/callback"
require "chatroid/adapter"

class Chatroid
  include Callback

  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def config
    @config ||= {}
  end

  def run!
    validate_connection
    adapter.connect
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

  # Post message via adapter
  def post(*args)
    adapter.post(*args)
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
    has_service? && adapter_class
  end

  def adapter_class
    Adapter.find(config[:service])
  end

  def adapter
    @adapter ||= adapter_class.new(self)
  end

  class ConnectionError < StandardError; end
end

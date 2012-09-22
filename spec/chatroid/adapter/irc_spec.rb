require "spec_helper"

describe Chatroid::Adapter::Irc do
  let(:chatroid) do
    Chatroid.new do
      extend Chatroid::Adapter::Irc
    end
  end
end

require "spec_helper"

describe Chatroid::Adapter::Twitter do
  let(:chatroid) do
    Chatroid.new do
      extend Chatroid::Adapter::Twitter
    end
  end

  describe "#connect" do
    it do
      chatroid.should be_respond_to(:connect, true)
    end

    it "should work in EventMachine::run" do
      EventMachine.should_receive(:run) do |&block|
        block.should be_a(Proc)
      end
      chatroid.send(:connect)
    end
  end
end

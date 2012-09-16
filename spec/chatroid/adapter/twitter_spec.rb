require "spec_helper"

describe Chatroid::Adapter::Twitter do
  let(:chatroid) do
    Chatroid.new do
      extend Chatroid::Adapter::Twitter
    end
  end

  describe "#connect" do
    it "should work in EventMachine::run" do
      EventMachine.should_receive(:run) do |&block|
        block.should be_a(Proc)
      end
      chatroid.send(:connect)
    end
  end

  describe "#tweet" do
    it "should call TwitterOAuth::Client#update with body" do
      TwitterOAuth::Client.any_instance.should_receive(:update).with("body")
      chatroid.send(:tweet, "body")
    end
  end

  describe "#reply" do
    it "should call TwitterOAuth::Client#update with body and id" do
      TwitterOAuth::Client.any_instance.should_receive(:update).
        with("@foo body", :in_reply_to_status_id => 1)
      chatroid.send(:reply, "body", "id" => 1, "user" => { "screen_name" => "foo" })
    end
  end

  describe "#favorite" do
    it "should call TwitterOAuth::Client#favorite with id" do
      TwitterOAuth::Client.any_instance.should_receive(:favorite).with("1")
      chatroid.send(:favorite, "id" => "1")
    end
  end
end

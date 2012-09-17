require "spec_helper"

describe Chatroid::Adapter::HipChat do
  let(:chatroid) do
    Chatroid.new do
      set :service, "HipChat"
      set :jid, "jid"
      set :room, "room@example.com"
      set :nick, "nick"
      set :password, "password"
    end
  end

  describe ".extended" do
    context "when chatroid has jid" do
      it do
        expect do
          chatroid.extend(Chatroid::Adapter::HipChat)
        end.to_not raise_error(Avalon::ValidationError)
      end
    end

    context "when chatroid has no jid" do
      before do
        chatroid.config.delete(:jid)
      end

      it do
        expect do
          chatroid.extend(Chatroid::Adapter::HipChat)
        end.to raise_error(Avalon::ValidationError)
      end
    end
  end

  describe "#connect" do
    before do
      Jabber::Client.stub(:new).and_return(client)
      Jabber::MUC::SimpleMUCClient.stub(:new).and_return(room)
      client.stub(:connect)
      client.stub(:auth)
      room.stub(:on_message)
      room.stub(:join)
      chatroid.stub(:persist)
    end

    let(:client) do
      mock
    end

    let(:room) do
      mock
    end

    it "should call Jabber::Client#connect" do
      client.should_receive(:connect)
      chatroid.run!
    end

    it "should call Jabber::Client#auth" do
      client.should_receive(:auth)
      chatroid.run!
    end

    it "should call Jabber::MUC::SimpleMUCClient#join" do
      room.should_receive(:join)
      chatroid.run!
    end
  end
end

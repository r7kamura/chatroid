require "spec_helper"

describe Chatroid::Adapter::Campfire do
  before do
    Tinder::Campfire.stub(:new).and_return(campfire)
    campfire.stub(:find_room_by_id).and_return(room)
    campfire.stub(:find_room_by_name).and_return(room)
  end

  let(:chatroid) do
    Chatroid.new do
      extend Chatroid::Adapter::Campfire
      set :subdomainm, 'example'
      set :token, 'token'
      set :room_id, 'room_id'
    end
  end

  let(:campfire) do
    mock.as_null_object
  end

  let(:room) do
    mock.as_null_object
  end

  describe "#speak" do
    it "calls Tinder::Room#speak with body" do
      room.should_receive(:speak).with("body")
      chatroid.send(:speak, "body")
    end
  end

  describe "#paste" do
    it "calls Tinder::Room#paste with body" do
      room.should_receive(:paste).with("body")
      chatroid.send(:paste, "body")
    end
  end

  describe "#play" do
    it "calls Tinder::Room#play with sound" do
      room.should_receive(:play).with("sound")
      chatroid.send(:play, "sound")
    end
  end

  describe "#tweet" do
    it "calls Tinder::Room#tweet with url" do
      url = "http://example.com/tweet"
      room.should_receive(:tweet).with(url)
      chatroid.send(:tweet, url)
    end
  end
end

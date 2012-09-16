require "spec_helper"

describe Chatroid::Adapter::Twitter do
  shared_examples_for "interface of Chatroid::Adapter" do
    it do
      Chatroid::Adapter::Twitter.should be_respond_to(:new)
    end

    it do
      Chatroid::Adapter::Twitter.new(mock).should be_respond_to(:connect)
    end

    it do
      Chatroid::Adapter::Twitter.new(mock).should be_respond_to(:post)
    end
  end

  it_should_behave_like "interface of Chatroid::Adapter"
end

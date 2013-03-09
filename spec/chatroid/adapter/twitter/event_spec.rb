require "spec_helper"

describe Chatroid::Adapter::Twitter::Event do
  describe "#type" do
    subject do
      Chatroid::Adapter::Twitter::Event.new(args.to_json, user_id).type
    end

    let(:args) do
      {}
    end

    let(:user_id) do
      1
    end

    let (:other_id) do
      2
    end

    context "when favorited" do
      let(:args) do
        { "event" => "favorite", "target" => { "id" => user_id } }
      end

      it do
        should == "favorite"
      end
    end

    context "when user favorited other's tweet" do
      let(:args) do
        { "event" => "favorite", "target" => { "id" => other_id } }
      end

      it do
        should == "favorite_other"
      end
    end

    context "when unfavorited" do
      let(:args) do
        { "event" => "unfavorite", "target" => { "id" => user_id } }
      end

      it do
        should == "unfavorite"
      end
    end

    context "when user's list is subscribed" do
      let(:args) do
        { "event" => "list_user_subscribed", "target" => { "id" => user_id } }
      end

      it do
        should == "list_user_subscribed"
      end
    end

    context "when user's list is unsubscribed" do
      let(:args) do
        { "event" => "list_user_unsubscribed", "target" => { "id" => user_id } }
      end

      it do
        should == "list_user_unsubscribed"
      end
    end

    context "when user is added to list" do
      let(:args) do
        { "event" => "list_member_added", "target" => { "id" => user_id } }
      end

      it do
        should == "list_member_added"
      end
    end

    context "when user is removed from list" do
      let(:args) do
        { "event" => "list_member_removed", "target" => { "id" => user_id } }
      end

      it do
        should == "list_member_removed"
      end
    end

    context "when replied" do
      let(:args) do
        { "in_reply_to_user_id" => user_id }
      end

      it do
        should == "reply"
      end
    end

    context "when tweeted" do
      let(:args) do
        { "text" => "foo" }
      end

      it do
        should == "tweet"
      end
    end
  end
end

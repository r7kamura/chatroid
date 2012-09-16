require "spec_helper"

describe Chatroid do
  describe "#set" do
    context "when given a hash" do
      it "should set it to config" do
        Chatroid.new { set :key => "val" }.config.should == { :key => "val" }
      end
    end

    context "when given two args" do
      it "should set it to config as key-value config" do
        Chatroid.new { set :key, "val" }.config.should == { :key => "val" }
      end
    end

    context "when given args more than two args" do
      it do
        expect do
          Chatroid.new { set 1, 2, 3 }
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe "#run!" do
    context "when service to connect is not specified" do
      it do
        expect do
          Chatroid.new.run!
        end.to raise_error(Chatroid::ConnectionError)
      end
    end

    context "when specified service is not supported" do
      it do
        expect do
          Chatroid.new { set :service, "NotSupportedService" }.run!
        end.to raise_error(Chatroid::ConnectionError)
      end
    end

    context "when specified service is supported" do
      let(:adapter) do
        Class.new do
          def initialize(chatroid)
          end

          def connect
          end
        end
      end

      it "should find adapter and call #connect of it" do
        chatroid = Chatroid.new
        chatroid.stub(:has_service?).and_return(true)
        chatroid.stub(:adapter).and_return(adapter)
        adapter.any_instance.should_receive(:connect)
        chatroid.run!
      end
    end
  end
end

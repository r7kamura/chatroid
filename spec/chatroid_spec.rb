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
        mock
      end

      it "should find adapter and call #connect extended from it" do
        chatroid = Chatroid.new
        chatroid.stub(:validate_connection)
        chatroid.stub(:adapter).and_return(adapter)
        chatroid.should_receive(:extend).with(adapter)
        chatroid.should_receive(:connect)
        chatroid.run!
      end
    end
  end
end

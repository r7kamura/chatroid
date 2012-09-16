require "spec_helper"

describe Chatroid do
  let(:instance) do
    described_class.new
  end

  describe "#set" do
    context "when given a hash" do
      it "should set it to config" do
        described_class.new { set :key => "val" }.config.should == { :key => "val" }
      end
    end

    context "when given two args" do
      it "should set it to config as key-value config" do
        described_class.new { set :key, "val" }.config.should == { :key => "val" }
      end
    end

    context "when given args more than two args" do
      it do
        expect do
          described_class.new { set 1, 2, 3 }
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe "#run!" do
    context "when service to connect is not specified" do
      it do
        expect do
          instance.run!
        end.to raise_error(described_class::ConnectionError)
      end
    end

    context "when specified service is not supported" do
      before do
        instance.stub(:has_service?).and_return(true)
        instance.stub(:has_adapter?).and_return(false)
      end

      it do
        expect do
          instance.run!
        end.to raise_error(described_class::ConnectionError)
      end
    end

    context "when specified service is supported" do
      before do
        instance.stub(:has_service?).and_return(true)
        instance.stub(:has_adapter?).and_return(true)
      end

      it "should find adapter and call #connect of it" do
        adapter = mock
        adapter_class = mock
        adapter_class.stub(:new).and_return(adapter)
        adapter.should_receive(:connect)
        instance.stub(:adapter_class).and_return(adapter_class)
        instance.run!
      end
    end
  end
end

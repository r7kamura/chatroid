require "spec_helper"

describe Chatroid::Bot do
  let(:instance) do
    described_class.new(args)
  end

  let(:args) do
    {}
  end

  describe "#initialize" do
    context "when not given any arguments" do
      it "should set empty hash as @config" do
        instance.config.should == args
      end
    end

    context "when given a hash" do
      let(:args) do
        { "foo" => "bar" }
      end

      it "should set it as @config" do
        instance.config.should == args
      end
    end
  end

  describe "#config" do
    it do
      instance.config.should be_a(Hashie::Mash)
    end
  end

  describe "#connect" do
    context "when service to connect is not specified" do
      it do
        expect do
          instance.connect
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
          instance.connect
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
        instance.connect
      end
    end
  end
end

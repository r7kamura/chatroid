require "spec_helper"

describe Yunotti::Bot do
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
end

require "spec_helper"

describe Sara::Callback do
  let(:klass) do
    mod = described_class
    Class.new { include mod }
  end

  describe ".included" do
    it "should extend includer with Sara::ClassMethods" do
      klass.singleton_class.ancestors.should include(described_class::ClassMethods)
    end
  end

  describe ".on_xxx" do
    it "should store given block as callback" do
      expect do
        klass.on_xxx {}
      end.to change { klass.list_xxx.size }.by(1)
    end
  end

  describe ".list_xxx" do
    context "before .on_xxx is called" do
      it do
        klass.list_xxx.should have(0).callback
      end
    end

    context "after .on_yyy is called" do
      before do
        klass.on_yyy {}
      end

      it do
        klass.list_xxx.should have(0).callback
      end
    end

    context "after .on_xxx is called" do
      before do
        klass.on_xxx {}
      end

      it do
        klass.list_xxx.should have(1).callback
      end
    end
  end

  describe ".trigger_xxx" do
    it "should trigger all callbacks for xxx" do
      callback = proc {}
      callback.should_receive(:call)
      klass.on_xxx(&callback)
      klass.trigger_xxx
    end

    it "should trigger callbacks with given args" do
      args = mock
      klass.on_xxx { |block_args| block_args.should == args }
      klass.trigger_xxx(args)
    end
  end
end

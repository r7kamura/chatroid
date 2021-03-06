require "spec_helper"

describe Chatroid::Callback do
  let(:instance) do
    mod = described_class
    Class.new { include mod }.new
  end

  describe "#on_xxx" do
    it "should store given block as callback" do
      callback = proc {}
      instance.on_xxx(&callback)
      instance.list_xxx.should == [callback]
    end
  end

  describe "#list_xxx" do
    context "before #on_xxx is called" do
      it do
        instance.list_xxx.should have(0).callback
      end
    end

    context "after #on_yyy is called" do
      before do
        instance.on_yyy {}
      end

      it do
        instance.list_xxx.should have(0).callback
      end
    end

    context "after #on_xxx is called" do
      before do
        instance.on_xxx {}
      end

      it do
        instance.list_xxx.should have(1).callback
      end
    end
  end

  describe "#trigger_xxx" do
    it "should trigger all callbacks for xxx" do
      callback = proc {}
      callback.should_receive(:call)
      instance.on_xxx(&callback)
      instance.trigger_xxx
    end

    it "should trigger callbacks with given args" do
      args = mock
      instance.on_xxx { |block_args| block_args.should == args }
      instance.trigger_xxx(args)
    end
  end

  describe "#method_missing" do
    it "should hundle under_score event like x_x" do
      callback = proc {}
      callback.should_receive(:call)
      instance.on_x_x(&callback)
      instance.send(:list, 'x_x').should_not be_empty
      instance.trigger_x_x
    end
  end
end

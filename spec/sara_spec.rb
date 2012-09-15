require "spec_helper"

describe Sara do
  let(:klass) do
    Class.new { include Sara }
  end

  describe ".included" do
    it "should extend includer with Sara::ClassMethods" do
      klass.singleton_class.ancestors.should include(described_class::ClassMethods)
    end
  end

  describe ".on_message" do
    it "should store given block as callback" do
      expect do
        klass.on_message { }
      end.to change { klass.on_messages.size }.by(1)
    end
  end

  describe ".on_messages" do
    context "when no callback is stored" do
      it do
        klass.on_messages.should have(0).callback
      end
    end

    context "when a callback is stored" do
      before do
        klass.on_message { }
      end

      it do
        klass.on_messages.should have(1).callback
      end
    end
  end

  describe ".do_message" do
    it "should trigger all callbacks registered as on_message" do
      callback = proc {}
      callback.should_receive(:call)
      klass.stub(:on_messages) { [callback] }
      klass.do_message(mock)
    end

    it "should trigger callbacks with given message" do
      message = mock
      klass.on_message { |callback| callback.should == message }
      klass.do_message(message)
    end
  end
end

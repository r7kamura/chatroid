require "spec_helper"

describe Chatroid::Adapter do
  describe ".find" do
    context "when proper adapter class exists" do
      before do
        Chatroid::Adapter.stub(:const_get).and_return(adapter_class)
      end

      let(:adapter_class) do
        Class.new
      end

      it "should return it" do
        Chatroid::Adapter.find("AdapterClassName").should == adapter_class
      end
    end

    context "when proper adapter class does not exist" do
      it do
        Chatroid::Adapter.find("AdapterClassName").should == nil
      end
    end
  end
end

require 'spec_helper'

describe Microformats::Helpers do
  class MyTester
    include Microformats::Helpers
  end
  
  before(:each) do
    @tester = MyTester.new
  end
  
  describe "vcard" do
    it "should wrap a block in a vcard div" do
      @tester.should_receive(:holla_back)
      @tester.should_receive(:concat).with("<div class='vcard'>\n")
      @tester.should_receive(:concat).with("</div>")
      @tester.vcard do
        @tester.holla_back
      end
    end
  end
end

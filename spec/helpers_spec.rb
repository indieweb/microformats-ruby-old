require 'spec_helper'

describe Microformats::Helpers do
  class MyTester
    include Microformats::Helpers
    
    def concat(str)
      @output ||= ''
      @output << str
    end
    
    def output
      @output
    end
  end
  
  before(:each) do
    @tester = MyTester.new
  end
  
  describe "vcard" do
    it "should wrap a block in a vcard div" do
      @tester.should_receive(:do_something)
      @tester.vcard do
        @tester.do_something
      end
      @tester.output.should == "<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\n</div>\n"
    end
  end
  
  describe "vcard_address" do
    context "with type" do
      it "should wrap the block in an adr div and output the type" do
        @tester.should_receive(:do_something)
        @tester.vcard_address :type => 'Work' do
          @tester.do_something
        end
        @tester.output.should == "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n<span class='type'>Work</span></div>\n"
      end
    end
    
    context "without type" do
      it "should wrap the block in an adr div" do
        @tester.should_receive(:do_something)
        @tester.vcard_address do
          @tester.do_something
        end
        @tester.output.should == "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n</div>\n"
      end
    end
  end
end

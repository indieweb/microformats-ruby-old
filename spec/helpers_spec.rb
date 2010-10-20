require 'spec_helper'

describe Microformats::Helpers do
  
  class MockTemplateWithHelpers < MockTemplate
    include Microformats::Helpers
  end
  
  before(:each) do
    @template = MockTemplateWithHelpers.new
  end
  
  describe "vcard" do
    it "should wrap a block in a vcard div" do
      @template.should_receive(:do_something)
      @template.vcard do |card|
        card.is_a?(Microformats::Vcard).should be_true
        @template.do_something
      end
      @template.output.should == "<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\n</div>\n"
    end
  end
  
  describe "vaddress" do
    context "with type" do
      it "should wrap the block in an adr div and output the type" do
        @template.should_receive(:do_something)
        @template.vaddress :type => 'work' do
          @template.do_something
        end
        @template.output.should == "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n<span class='type'><span class='value-title' title='work'></span></span></div>\n"
      end
    end
    
    context "without type" do
      it "should wrap the block in an adr div" do
        @template.should_receive(:do_something)
        @template.vaddress do |adr|
          adr.is_a?(Microformats::Address).should be_true
          @template.do_something
        end
        @template.output.should == "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n</div>\n"
      end
    end
  end
  
  describe "vevent" do
    it "should wrap a block in a vevent div" do
      @template.should_receive(:do_something)
      @template.vcard do
        @template.do_something
      end
      @template.output.should == "<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\n</div>\n"
    end
  end
  
  describe "vevent" do
    it "should wrap the block with a .vevent div" do
      @template.should_receive(:do_something)
      @template.vevent do |event|
        event.is_a?(Microformats::Event).should be_true
        @template.do_something
      end
      @template.output.should == "<div class='vevent' itemscope='itemscope' itemtype='http://data-vocabulary.org/Event'>\n</div>\n"
    end
    
    it "should add passed attributes to .vevent element" do
      @template.should_receive(:do_something)
      @template.vevent(:id => 'my_event', :class => 'extra', :tag => 'section') do |event|
        @template.do_something
      end
      @template.output.should == "<section class='extra vevent' id='my_event' itemscope='itemscope' itemtype='http://data-vocabulary.org/Event'>\n</section>\n"
    end
  end
  
  describe "vcalendar" do
    it "should wrap the block with a .vcalendar div" do
      @template.should_receive(:do_something)
      @template.vcalendar do |cal|
        cal.is_a?(Microformats::Calendar).should be_true
        @template.do_something
      end
      @template.output.should == "<div class='vcalendar'>\n</div>\n"
    end
    
    it "should add passed attributes to .vcalendar element" do
      @template.should_receive(:do_something)
      @template.vcalendar(:id => 'my_cal', :class => 'extra', :tag => 'section') do |cal|
        @template.do_something
      end
      @template.output.should == "<section class='extra vcalendar' id='my_cal'>\n</section>\n"
    end
  end
end

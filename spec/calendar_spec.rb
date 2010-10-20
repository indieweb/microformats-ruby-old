require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Microformats::Calendar do
  before(:each) do
    @template = MockTemplate.new
    @cal = Microformats::Calendar.new(@template)
  end
  
  describe "run" do
    it "should wrap the block with a .vcalendar div" do
      @cal.run do |cal|
        cal.concat "Hello"
      end
      @template.output.should == "<div class='vcalendar'>\nHello</div>\n"
    end
    
    it "should add passed attributes to .vcalendar element" do
      @cal.run(:id => 'my_cal', :class => 'extra', :tag => 'section') do |cal|
        cal.concat "Hello"
      end
      @template.output.should == "<section class='extra vcalendar' id='my_cal'>\nHello</section>\n"
    end
  end
  
  describe "event" do
    before(:each) do
      @event = Microformats::Event.new(@template)
      Microformats::Event.should_receive(:new).with(@template).and_return(@event)
    end
    
    it "should run the block on a new event" do
      @event.should_receive(:run).with(:class => 'vevent')
      @cal.event do |e|
        # won't get run in test because #run is stubbed
      end
    end
    
    it "should use the given tag" do
      @event.should_receive(:run).with(:class => 'vevent', :tag => :section)
      @cal.event(:tag => :section) do |e|
        # won't get run in test because #run is stubbed
      end
    end
    
    it "should pass along html opts" do
      @event.should_receive(:run).with(:class => 'extra vevent', :id => 'my_event')
      @cal.event(:class => 'extra', :id => 'my_event') do |e|
        # won't get run in test because #run is stubbed
      end
    end
  end
end
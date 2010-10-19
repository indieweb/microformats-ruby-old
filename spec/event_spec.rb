require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Microformats::Event do
  before(:each) do
    @template = MockTemplate.new
    @event = Microformats::Event.new(@template)
  end
  
  describe "name" do
    it "should wrap the string with summary" do
      @event.name("My Event").should == "<span class='summary' itemprop='summary'>My Event</span>"
    end
    
    it "should use the given tag" do
      @event.name("My Event", :tag => :strong).should == "<strong class='summary' itemprop='summary'>My Event</strong>"
    end
  end
  
  describe "url" do
    it "should default to a tag with url class, using the URL for text and href" do
      @event.url("http://google.com").should == "<a class='url' href='http://google.com' itemprop='url'>http://google.com</a>"
    end
    
    it "should use given href" do
      @event.url('Google', :href => "http://google.com").should == "<a class='url' href='http://google.com' itemprop='url'>Google</a>"
    end
    
    it "should use given tag" do
      @event.url('http://google.com', :tag => :strong).should == "<strong class='url' itemprop='url'>http://google.com</strong>"
    end
  end
  
  describe "photo" do
    it "should create an image tag using the passed string as the src, adding itemprop photo" do
      @event.photo("/images/event.png").should == "<img itemprop='photo' src='/images/event.png' />"
    end
    
    it "should use :size option to set width and height" do
      @event.photo("/images/event.png", :size => "200x100").should == "<img height='100' itemprop='photo' src='/images/event.png' width='200' />"
    end
    
    it "should pass through options" do
      @event.photo("/images/event.png", :height => 100, :width => 200).should == "<img height='100' itemprop='photo' src='/images/event.png' width='200' />"
    end
  end
  
  describe "description" do
    it "should wrap the string with description" do
      @event.description("My Event").should == "<span class='description' itemprop='description'>My Event</span>"
    end
    
    it "should use the given tag" do
      @event.description("My Event", :tag => :strong).should == "<strong class='description' itemprop='description'>My Event</strong>"
    end
  end
  
  describe "starts_at" do
    it "should output the time wrapped in a time tag with encoded time" do
      t = Time.local(2010, 10, 20, 19, 30) # Oct 20, 2010 at 7:30pm
      @event.starts_at(t).should == "<time class='dtstart' datetime='2010-10-20T19:30-05:00' itemprop='startDate'><span class='value-title' title='2010-10-20T19:30-05:00'></span>Oct 20, 2010 at 7:30PM</time>"
    end
    
    it "should accept a datetime string instead of a time object" do
      pending
      @event.starts_at("October 20, 2010 7:30pm").should == "<time class='dtstart' datetime='2010-10-20T19:30-05:00' itemprop='startDate'><span class='value-title' title='2010-10-20T19:30-05:00'></span>October 20, 2010 7:30pm</time>"
    end
    
    it "should accept a time object with a display string as :text" do
      t = Time.local(2010, 10, 20, 19, 30) # Oct 20, 2010 at 7:30pm
      @event.starts_at(t, :text => "Sometime").should == "<time class='dtstart' datetime='2010-10-20T19:30-05:00' itemprop='startDate'><span class='value-title' title='2010-10-20T19:30-05:00'></span>Sometime</time>"
    end
  end
  
  describe "ends_at" do
    it "should output the time wrapped in a time tag with encoded time" do
      t = Time.local(2010, 10, 20, 19, 30) # Oct 20, 2010 at 7:30pm
      @event.ends_at(t).should == "<time class='dtend' datetime='2010-10-20T19:30-05:00' itemprop='endDate'><span class='value-title' title='2010-10-20T19:30-05:00'></span>Oct 20, 2010 at 7:30PM</time>"
    end
    
    it "should accept a datetime string instead of a time object" do
      pending
      @event.ends_at("October 20, 2010 7:30pm").should == "<time class='dtend' datetime='2010-10-20T19:30-05:00' itemprop='endDate'><span class='value-title' title='2010-10-20T19:30-05:00'></span>October 20, 2010 7:30pm</time>"
    end
    
    it "should accept a time object with a display string as :text" do
      t = Time.local(2010, 10, 20, 19, 30) # Oct 20, 2010 at 7:30pm
      @event.ends_at(t, :text => "Sometime").should == "<time class='dtend' datetime='2010-10-20T19:30-05:00' itemprop='endDate'><span class='value-title' title='2010-10-20T19:30-05:00'></span>Sometime</time>"
    end
  end
  
  describe "category" do
    it "should wrap the string with category class and eventType itemprop" do
      @event.category("Geekfest").should == "<span class='category' itemprop='eventType'>Geekfest</span>"
    end
    
    it "should use the given tag" do
      @event.category("Geekfest", :tag => :strong).should == "<strong class='category' itemprop='eventType'>Geekfest</strong>"
    end
  end
  
  describe "location" do
    before(:each) do
      @card = Microformats::Vcard.new(@template)
      Microformats::Vcard.should_receive(:new).with(@template).and_return(@card)
    end
    it "should run the block on a new vcard" do
      @card.should_receive(:run).with(:class => 'location')
      @event.location do |card|
        # won't get run in test because #run is stubbed
      end
    end
    
    it "should pass along html opts" do
      @card.should_receive(:run).with(:class => 'extra location', :id => 'my_location')
      @event.location(:class => 'extra', :id => 'my_location') do |card|
        # won't get run in test because #run is stubbed
      end
    end
  end
  
  describe "duration" do
    it "should output a tag for duration" do
      pending
    end
  end
end
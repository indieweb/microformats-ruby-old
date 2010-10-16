require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Microformats::Event do
  before(:each) do
    @event = Microformats::Event.new
  end
  
  describe "name" do
    it "should wrap the string with summary" do
      @event.name("My Event").should == "<span itemprop='summary'>My Event</span>"
    end
    
    it "should use the given tag" do
      @event.name("My Event", :tag => :strong).should == "<strong itemprop='summary'>My Event</strong>"
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
  
  # url, description, dtstart - startDate, dtend - endDate, duration, category - eventType, 
  # geo (latitude, longitude), photo
  
end
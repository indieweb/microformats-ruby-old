require 'spec_helper'

describe Microformats::Address do
  before(:each) do
    @template = MockTemplate.new
    @address = Microformats::Address.new(@template)
  end
  
  describe "run" do
    it "should wrap the block with an .adr div" do
      @address.run do |adr|
        adr.concat "Hello"
      end
      @template.output.should == "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\nHello</div>\n"
    end
    
    it "should add passed attributes to .adr div" do
      @address.run(:id => 'my_address', :class => 'extra') do |adr|
        adr.concat "Hello"
      end
      @template.output.should == "<div class='adr extra' id='my_address' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\nHello</div>\n"
    end
  end
  
  describe "type" do
    it "should output the type string as a hidden value" do
      @address.type('home').should == "<span class='type'><span class='value-title' title='home'></span></span>"
    end
    
    it "should include text passed with :text option" do
      @address.type('home', :text => "Where I Live").should == "<span class='type'><span class='value-title' title='home'></span>Where I Live</span>"
    end
  end
  
  describe "street" do
    it "should wrap the string with street-address" do
      e = "<span class='street-address' itemprop='street-address'>123 Main</span>"
      @address.street("123 Main").should == e
    end
    
    it "should use passed html attrs" do
      e = "<span class='extra street-address' id='my_street' itemprop='street-address'>123 Main</span>"
      @address.street("123 Main", :class => 'extra', :id => 'my_street').should == e
    end
    
    it "should use the given tag" do
      e = "<strong class='street-address' itemprop='street-address'>123 Main</strong>"
      @address.street("123 Main", :tag => :strong).should == e
    end
  end
  
  describe "city" do
    it "should wrap the string with locality" do
      @address.city("Chicago").should == "<span class='locality' itemprop='locality'>Chicago</span>"
    end

    it "should use passed html attrs" do
      e = "<span class='extra locality' id='my_city' itemprop='locality'>Chicago</span>"
      @address.city("Chicago", :class => 'extra', :id => 'my_city').should == e
    end
    
    it "should use the given tag" do
      @address.city("Chicago", :tag => :strong).should == "<strong class='locality' itemprop='locality'>Chicago</strong>"
    end
  end
  
  describe "state" do
    it "should wrap the string with region" do
      @address.state("IL").should == "<span class='region' itemprop='region'>IL</span>"
    end
    
    it "should use passed html attrs" do
      e = "<span class='extra region' id='my_state' itemprop='region'>IL</span>"
      @address.state("IL", :class => 'extra', :id => 'my_state').should == e
    end
    
    it "should use the given tag" do
      @address.state("IL", :tag => :strong).should == "<strong class='region' itemprop='region'>IL</strong>"
    end
  end
  
  describe "zip" do
    it "should wrap the string with postal-code" do
      @address.zip("60085").should == "<span class='postal-code' itemprop='postal-code'>60085</span>"
    end
    
    it "should use passed html attrs" do
      e = "<span class='extra postal-code' id='my_zip' itemprop='postal-code'>60085</span>"
      @address.zip("60085", :class => 'extra', :id => 'my_zip').should == e
    end
    
    it "should use the given tag" do
      @address.zip("60085", :tag => :strong).should == "<strong class='postal-code' itemprop='postal-code'>60085</strong>"
    end
  end
  
  describe "country" do
    it "should wrap the string with country-name" do
      @address.country("USA").should == "<span class='country-name' itemprop='country-name'>USA</span>"
    end
    
    it "should use passed html attrs" do
      e = "<span class='country-name extra' id='my_country' itemprop='country-name'>USA</span>"
      @address.country("USA", :class => 'extra', :id => 'my_country').should == e
    end
    
    it "should use the given tag" do
      @address.country("USA", :tag => :strong).should == "<strong class='country-name' itemprop='country-name'>USA</strong>"
    end
  end
end

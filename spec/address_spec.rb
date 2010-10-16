require 'spec_helper'

describe Microformats::Address do
  before(:each) do
    @address = Microformats::Address.new
  end
  
  describe "type" do
    it "should output the type string as a hidden value" do
      @address.type('home').should == "<span class='type'><span class='value-title' title='home'></span></span>"
    end
  end
  
  describe "street" do
    it "should wrap the string with street-address" do
      @address.street("123 Main").should == "<span class='street-address' itemprop='street-address'>123 Main</span>"
    end
    
    it "should use the given tag" do
      @address.street("123 Main", :tag => :strong).should == "<strong class='street-address' itemprop='street-address'>123 Main</strong>"
    end
  end
  
  describe "city" do
    it "should wrap the string with locality" do
      @address.city("Chicago").should == "<span class='locality' itemprop='locality'>Chicago</span>"
    end
    
    it "should use the given tag" do
      @address.city("Chicago", :tag => :strong).should == "<strong class='locality' itemprop='locality'>Chicago</strong>"
    end
  end
  
  describe "state" do
    it "should wrap the string with region" do
      @address.state("IL").should == "<span class='region' itemprop='region'>IL</span>"
    end
    
    it "should use the given tag" do
      @address.state("IL", :tag => :strong).should == "<strong class='region' itemprop='region'>IL</strong>"
    end
  end
  
  describe "zip" do
    it "should wrap the string with postal-code" do
      @address.zip("60085").should == "<span class='postal-code' itemprop='postal-code'>60085</span>"
    end
    
    it "should use the given tag" do
      @address.zip("60085", :tag => :strong).should == "<strong class='postal-code' itemprop='postal-code'>60085</strong>"
    end
  end
  
  describe "country" do
    it "should wrap the string with country-name" do
      @address.country("USA").should == "<span class='country-name' itemprop='country-name'>USA</span>"
    end
    
    it "should use the given tag" do
      @address.country("USA", :tag => :strong).should == "<strong class='country-name' itemprop='country-name'>USA</strong>"
    end
  end
end

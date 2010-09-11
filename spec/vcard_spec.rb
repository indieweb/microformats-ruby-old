require 'spec_helper'

describe Microformats::Vcard do
  before(:each) do
    @vcard = Microformats::Vcard.new
  end
  
  describe "name" do
    it "should wrap a string with fn class, default to span" do
      @vcard.name("John Doe").should == "<span class='fn'>John Doe</span>"
    end
    
    it "should use the given tag" do
      @vcard.name("John Doe", :tag => :strong).should == "<strong class='fn'>John Doe</strong>"
    end
  end
  
  describe "company" do
    it "should wrap a string with org class, default to span" do
      @vcard.company("Acme Co.").should == "<span class='org'>Acme Co.</span>"
    end
    
    it "should use the given tag" do
      @vcard.company("Acme Co.", :tag => :strong).should == "<strong class='org'>Acme Co.</strong>"
    end
  end
  
  describe "url" do
    it "should default to a tag with url class, using the URL for text and href" do
      @vcard.url("http://google.com").should == "<a class='url' href='http://google.com'>http://google.com</a>"
    end
    
    it "should use given href" do
      @vcard.url('Google', :href => "http://google.com").should == "<a class='url' href='http://google.com'>Google</a>"
    end
    
    it "should use given tag" do
      @vcard.url('http://google.com', :tag => :strong).should == "<strong class='url'>http://google.com</strong>"
    end
  end
  
  describe "phone" do
    it "should wrap string with a tel class" do
      @vcard.phone('123.456.7890').should == "<span class='tel'>123.456.7890</span>"
    end
    
    it "should add a type span if given" do
      out = @vcard.phone('123.456.7890', :type => 'Work')
      out.should == "<span class='tel'><span class='type'>Work</span> 123.456.7890</span>"
    end
    
    it "should use the given tag" do
      out = @vcard.phone('123.456.7890', :type => 'Work', :tag => :strong)
      out.should == "<strong class='tel'><span class='type'>Work</span> 123.456.7890</strong>"
    end
  end
  
  describe "email" do
    it "should wrap string with a email class" do
      @vcard.email('john@doe.com').should == "<span class='email'>john@doe.com</span>"
    end
    
    it "should add a type span if given" do
      out = @vcard.email('john@doe.com', :type => 'Work')
      out.should == "<span class='email'><span class='type'>Work</span> john@doe.com</span>"
    end
    
    it "should use the given tag" do
      out = @vcard.email('john@doe.com', :type => 'Work', :tag => :strong)
      out.should == "<strong class='email'><span class='type'>Work</span> john@doe.com</strong>"
    end
    
    it "should use mailto if using an 'a' tag" do
      out = @vcard.email('john@doe.com', :type => 'Work', :tag => :a)
      out.should == "<a class='email' href='mailto:john@doe.com'><span class='type'>Work</span> john@doe.com</a>"
    end
  end
end

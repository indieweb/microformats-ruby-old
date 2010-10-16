require 'spec_helper'

describe Microformats::Vcard do
  before(:each) do
    @vcard = Microformats::Vcard.new
  end
  
  describe "name" do
    it "should wrap a string with fn class, default to span" do
      @vcard.name("John Doe").should == "<span class='fn' itemprop='name'>John Doe</span>"
    end
    
    it "should use the given tag" do
      @vcard.name("John Doe", :tag => :strong).should == "<strong class='fn' itemprop='name'>John Doe</strong>"
    end
  end
  
  describe "company" do
    it "should wrap a string with org class, default to span" do
      @vcard.company("Acme Co.").should == "<span class='org' itemprop='affiliation'>Acme Co.</span>"
    end
    
    it "should use the given tag" do
      @vcard.company("Acme Co.", :tag => :strong).should == "<strong class='org' itemprop='affiliation'>Acme Co.</strong>"
    end
  end
  
  describe "url" do
    it "should default to a tag with url class, using the URL for text and href" do
      @vcard.url("http://google.com").should == "<a class='url' href='http://google.com' itemprop='url'>http://google.com</a>"
    end
    
    it "should use given href" do
      @vcard.url('Google', :href => "http://google.com").should == "<a class='url' href='http://google.com' itemprop='url'>Google</a>"
    end
    
    it "should use given tag" do
      @vcard.url('http://google.com', :tag => :strong).should == "<strong class='url' itemprop='url'>http://google.com</strong>"
    end
  end
  
  describe "photo" do
    it "should create an image tag using the passed string as the src, adding itemprop photo" do
      @vcard.photo("/images/me.png").should == "<img itemprop='photo' src='/images/me.png' />"
    end
    
    it "should use :size option to set width and height" do
      @vcard.photo("/images/me.png", :size => "200x100").should == "<img height='100' itemprop='photo' src='/images/me.png' width='200' />"
    end
    
    it "should pass through options" do
      @vcard.photo("/images/me.png", :height => 100, :width => 200).should == "<img height='100' itemprop='photo' src='/images/me.png' width='200' />"
    end
    
  end
  
  describe "phone" do
    it "should wrap string with a tel class" do
      @vcard.phone('123.456.7890').should == "<span class='tel'>123.456.7890</span>"
    end
    
    it "should add a type span if given" do
      out = @vcard.phone('123.456.7890', :type => 'work')
      out.should == "<span class='tel'><span class='type'><span class='value-title' title='work'></span></span>123.456.7890</span>"
    end
    
    it "should use the given tag" do
      out = @vcard.phone('123.456.7890', :type => 'work', :tag => :strong)
      out.should == "<strong class='tel'><span class='type'><span class='value-title' title='work'></span></span>123.456.7890</strong>"
    end
  end
  
  describe "email" do
    it "should wrap string with a email class" do
      @vcard.email('john@doe.com').should == "<span class='email'>john@doe.com</span>"
    end
    
    it "should add a type span if given" do
      out = @vcard.email('john@doe.com', :type => 'work')
      out.should == "<span class='email'><span class='type'><span class='value-title' title='work'></span></span>john@doe.com</span>"
    end
    
    it "should use the given tag" do
      out = @vcard.email('john@doe.com', :type => 'work', :tag => :strong)
      out.should == "<strong class='email'><span class='type'><span class='value-title' title='work'></span></span>john@doe.com</strong>"
    end
    
    it "should use mailto if using an 'a' tag" do
      out = @vcard.email('john@doe.com', :type => 'work', :tag => :a)
      out.should == "<a class='email' href='mailto:john@doe.com'><span class='type'><span class='value-title' title='work'></span></span>john@doe.com</a>"
    end
  end
  
  describe "download_link" do
    it "should output a link to h2vx.com using the passed url" do
      out = @vcard.download_link('mydomain.com/page')
      out.should == "<a href='http://h2vx.com/vcf/mydomain.com/page' type='text/directory'>Download vCard</a>"
    end
    
    it "should strip the protocol from a passed url" do
      out = @vcard.download_link('http://mydomain.com/page')
      out.should == "<a href='http://h2vx.com/vcf/mydomain.com/page' type='text/directory'>Download vCard</a>"
    end
    
    it "should use :text option as text node if present" do
      out = @vcard.download_link('mydomain.com/page', :text => "Download Me Now")
      out.should == "<a href='http://h2vx.com/vcf/mydomain.com/page' type='text/directory'>Download Me Now</a>"
    end
  end
end

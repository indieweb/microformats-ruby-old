require 'spec_helper'

describe Microformats::Vcard do
  before(:each) do
    @template = MockTemplate.new
    @vcard = Microformats::Vcard.new(@template)
  end
  
  describe "run" do
    it "should wrap the block in a .vcard div" do
      @vcard.run do |card|
        card.concat "Hello"
      end
      @template.output.should == "<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\nHello</div>\n"
    end
    
    it "should should apply id and extra classes to .vcard div" do
      @vcard.run(:id => 'my_vcard', :class => 'extra') do |card|
        card.concat "Hello"
      end
      @template.output.should == "<div class='extra vcard' id='my_vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\nHello</div>\n"
    end
  end
  
  describe "name" do
    it "should wrap a string with fn class, default to span" do
      @vcard.name("John Doe").should == "<span class='fn' itemprop='name'>John Doe</span>"
    end
    
    it "should use arbitrary html attrs" do
      e = "<span class='extra fn' id='my_name' itemprop='name'>John Doe</span>"
      @vcard.name("John Doe", :class => 'extra', :id => 'my_name').should == e
    end
    
    it "should use the given tag" do
      @vcard.name("John Doe", :tag => :strong).should == "<strong class='fn' itemprop='name'>John Doe</strong>"
    end
  end
  
  describe "company" do
    it "should wrap a string with org class, default to span" do
      @vcard.company("Acme Co.").should == "<span class='org' itemprop='affiliation'>Acme Co.</span>"
    end
    
    it "should use arbitrary html attrs" do
      e = "<span class='extra org' id='my_company' itemprop='affiliation'>Acme Co.</span>"
      @vcard.company("Acme Co.", :class => 'extra', :id => 'my_company').should == e
    end
    
    it "should use the given tag" do
      @vcard.company("Acme Co.", :tag => :strong).should == "<strong class='org' itemprop='affiliation'>Acme Co.</strong>"
    end
    
    it "should have fn class if passed :is_company => true" do
      @vcard.company("Acme Co.", :is_company => true).should == "<span class='fn org' itemprop='affiliation'>Acme Co.</span>"
    end
  end
  
  describe "url" do
    it "should default to a tag with url class, using the URL for text and href" do
      @vcard.url("http://google.com").should == "<a class='url' href='http://google.com' itemprop='url'>http://google.com</a>"
    end
    
    it "should use arbitrary html attrs" do
      e = "<a class='extra url' href='http://google.com' id='my_url' itemprop='url'>http://google.com</a>"
      @vcard.url("http://google.com", :class => 'extra', :id => 'my_url').should == e
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
      @vcard.photo("/images/me.png").should == "<img class='photo' itemprop='photo' src='/images/me.png' />"
    end
    
    it "should use arbitrary html attrs" do
      e = "<img class='extra photo' id='my_photo' itemprop='photo' src='/images/me.png' />"
      @vcard.photo("/images/me.png", :class => 'extra', :id => 'my_photo').should == e
    end
    
    it "should use :size option to set width and height" do
      @vcard.photo("/images/me.png", :size => "200x100").should == "<img class='photo' height='100' itemprop='photo' src='/images/me.png' width='200' />"
    end
    
    it "should pass through options" do
      @vcard.photo("/images/me.png", :height => 100, :width => 200).should == "<img class='photo' height='100' itemprop='photo' src='/images/me.png' width='200' />"
    end
  end
  
  describe "phone" do
    it "should wrap string with a tel class" do
      @vcard.phone('123.456.7890').should == "<span class='tel'>123.456.7890</span>"
    end
    
    it "should use arbitrary html attrs" do
      e = "<span class='extra tel' id='my_phone'>123.456.7890</span>"
      @vcard.phone('123.456.7890', :class => 'extra', :id => 'my_phone').should == e
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
    it "should use mailto and default to 'a' tag" do
      out = @vcard.email('john@doe.com')
      out.should == "<a class='email' href='mailto:john@doe.com'>john@doe.com</a>"
    end
    
    it "should wrap string with passed tag" do
      @vcard.email('john@doe.com', :tag => :span).should == "<span class='email'>john@doe.com</span>"
    end
    
    it "should use arbitrary html attrs" do
      e = "<a class='email extra' href='mailto:john@doe.com' id='my_email'>john@doe.com</a>"
      @vcard.email('john@doe.com', :class => 'extra', :id => 'my_email').should == e
    end
    
    it "should add a type span if given" do
      out = @vcard.email('john@doe.com', :type => 'work')
      out.should == "<a class='email' href='mailto:john@doe.com'><span class='type'><span class='value-title' title='work'></span></span>john@doe.com</a>"
    end
    
    it "should use the given tag" do
      out = @vcard.email('john@doe.com', :type => 'work', :tag => :strong)
      out.should == "<strong class='email'><span class='type'><span class='value-title' title='work'></span></span>john@doe.com</strong>"
    end
  end
  
  describe "coordinates" do
    it "should output a geo container with meta and spans for lat and long" do
      out = @vcard.coordinates(37.774929, -122.419416)
      out.should == "<span class='geo' itemprop='geo' itemscope='itemscope' itemtype='http://data-vocabulary.org/Geo'><meta content='37.774929' itemprop='latitude'></meta><meta content='-122.419416' itemprop='longitude'></meta><span class='latitude'><span class='value-title' title='37.774929'></span></span><span class='longitude'><span class='value-title' title='-122.419416'></span></span></span>"      
    end
    
    it "should output text in .geo span if in options" do
      out = @vcard.coordinates(37.774929, -122.419416, :text => "My Location")
      out.should == "<span class='geo' itemprop='geo' itemscope='itemscope' itemtype='http://data-vocabulary.org/Geo'><meta content='37.774929' itemprop='latitude'></meta><meta content='-122.419416' itemprop='longitude'></meta><span class='latitude'><span class='value-title' title='37.774929'></span></span><span class='longitude'><span class='value-title' title='-122.419416'></span></span>My Location</span>"      
    end
  end
  
  describe "download_link" do
    it "should output a link to h2vx.com using the passed url" do
      out = @vcard.download_link('mydomain.com/page')
      out.should == "<a href='http://h2vx.com/vcf/mydomain.com/page' type='text/directory'>Download vCard</a>"
    end
    
    it "should use arbitrary html attrs" do
      out = @vcard.download_link('mydomain.com/page', :class => 'extra', :id => 'my_link')
      out.should == "<a class='extra' href='http://h2vx.com/vcf/mydomain.com/page' id='my_link' type='text/directory'>Download vCard</a>"
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
  
  describe "address" do
    before(:each) do
      @adr = Microformats::Address.new(@template)
      Microformats::Address.should_receive(:new).with(@template).and_return(@adr)
    end
    
    it "should run the block on a new vaddress" do
      @adr.should_receive(:run)
      @vcard.address do |adr|
        # won't get run in test because #run is stubbed
      end
    end
    
    it "should pass along html opts" do
      @adr.should_receive(:run).with(:class => 'extra', :id => 'my_address')
      @vcard.address(:class => 'extra', :id => 'my_address') do |adr|
        # won't get run in test because #run is stubbed
      end
    end
  end
end

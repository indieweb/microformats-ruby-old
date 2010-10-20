require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Microformats::FormattingHelpers do
  class Tester
    include Microformats::FormattingHelpers
    def initialize
      @default_tag = :span
    end
  end
  
  before(:each) do
    @tester = Tester.new
  end
  
  describe "combine_class_names" do
    it "should join the args with spaces alphebetized" do
      @tester.combine_class_names('one', 'two', 'three').should == "one three two"
    end
    
    it "should join arrays of class names" do
      out = @tester.combine_class_names(['one', 'two'], 'three', ['four', 'five'])
      out.should == "five four one three two"
    end
    
    it "should not include nils" do
      @tester.combine_class_names('one', [nil, 'two']).should == "one two"
    end
    
    it "should return nil if no classes" do
      @tester.combine_class_names(nil, nil).should == nil
    end
  end
  
  describe "content_tag" do
    it "should output default tag with attrs in alphabetical order" do
      out = @tester.content_tag('hello', :id => 'my_id', :class => 'klass')
      out.should == "<span class='klass' id='my_id'>hello</span>"
    end
    
    it "should not include attrs with nil values" do
      out = @tester.content_tag('hello', :id => 'my_id', :class => nil)
      out.should == "<span id='my_id'>hello</span>"      
    end
  end
end
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'erb'

describe "Integration" do
  class TemplateContext
    include Microformats::Helpers
    
    def initialize(erb)
      @erb = erb
    end
    
    def concat(str)
      raise @erb.inspect
    end
    
    def get_binding
      binding
    end
  end
  
  describe "vcard" do
    it "should have the expected output when run through ERB" do
      desired = File.read(File.join(File.dirname(__FILE__), 'templates', 'vcard.html'))
      template = ERB.new(File.read(File.join(File.dirname(__FILE__), 'templates', 'vcard.html.erb')))
      template.result(TemplateContext.new(template).get_binding).should == desired
    end
  end
end
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'microformats.rb')

# We need to be able to test what Vcard is outputting using the
# concat method. The output method just lets us check this.
class MockTemplate
  def concat(str)
    @output ||= ''
    @output << str
  end

  def output
    @output
  end
end
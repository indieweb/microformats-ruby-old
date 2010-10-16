module Microformats::Helpers
  # FIXME: Figure out how to make this non-Rails specific
  # i.e. not rely on using concat
  def vcard(&block)
    concat "<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\n"
    block.call(Microformats::Vcard.new)
    concat "</div>\n"
  end

  # FIXME: Figure out how to make this non-Rails specific
  # i.e. not rely on using concat
  def vcard_address(opts = {}, &block)
    address = Microformats::Address.new
    type = opts[:type] ? address.type(opts[:type]) : nil
    concat "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n"
    concat type if type
    block.call(address)
    concat "</div>\n"
  end

end
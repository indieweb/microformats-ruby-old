module Microformats::Helpers

  def vcard(&block)
    concat "<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>\n"
    block.call(Microformats::Vcard.new)
    concat "</div>\n"
  end

  def vcard_address(opts = {}, &block)
    address = Microformats::Address.new
    type = opts[:type] ? address.content_tag(:span, opts[:type], :class => 'type') : nil
    concat "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n"
    concat type if type
    block.call(address)
    concat "</div>\n"
  end

end
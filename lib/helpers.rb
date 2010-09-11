module Microformats::Helpers

  def vcard(&block)
    concat "<div class='vcard'>\n"
    block.call(Microformats::Vcard.new(self))
    concat "</div>\n"
  end

  def vcard_address(opts = {}, &block)
    type = opts[:type] ? @t.content_tag(:span, opts[:type], :class => 'type') : nil
    @t.concat "<div class='adr'>\n"
    @t.concat type if type.present?
    block.call(Address.new(@t))
    @t.concat "</div>\n"
  end

end
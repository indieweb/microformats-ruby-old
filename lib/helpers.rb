module Microformats::Helpers
  def vcard(&block)
    card = Microformats::Vcard.new(self)
    card.run(&block)
  end

  def vcard_address(opts = {}, &block)
    address = Microformats::Address.new(self)
    address.run(opts, &block)
  end

end
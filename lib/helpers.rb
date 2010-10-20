module Microformats::Helpers
  def vcard(&block)
    card = Microformats::Vcard.new(self)
    card.run(&block)
  end

  def vaddress(opts = {}, &block)
    address = Microformats::Address.new(self)
    address.run(opts, &block)
  end

  def vevent

  end

  def vcalendar

  end
end
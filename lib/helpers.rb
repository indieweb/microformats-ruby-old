module Microformats::Helpers
  def vcard(&block)
    card = Microformats::Vcard.new(self)
    card.run(&block)
  end

  def vaddress(opts = {}, &block)
    address = Microformats::Address.new(self)
    address.run(opts, &block)
  end

  def vevent(opts = {}, &block)
    event = Microformats::Event.new(self)
    event.run(opts, &block)
  end

  def vcalendar(opts = {}, &block)
    cal = Microformats::Calendar.new(self)
    cal.run(opts, &block)
  end
end
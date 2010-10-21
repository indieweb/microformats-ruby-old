# Include this file into your view layer. For example, in Rails:
#
#   module ApplicationHelper
#     include Microformats::Helpers
#   end
#
module Microformats::Helpers
  # Creates a vCard with the given options and a block.
  #
  # OPTIONS:
  # :tag - The HTML wrapper element (defaults to :div)
  # Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% vcard :id => 'my_vcard' do |card| %>
  #     Hello, my name is <%= card.name "Chris" %>!
  #   <% end %>
  #
  def vcard(opts = {}, &block)
    card = Microformats::Vcard.new(self)
    card.run(opts, &block)
  end

  # Creates a vAddress with the given options and a block.
  #
  # OPTIONS:
  # :type - A string that specifies the type of address('home', 'work', etc)
  # :tag - The HTML wrapper element (defaults to :div)
  # Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% vaddress :type => 'work', :id => 'my_adr' do |adr| %>
  #     I live at <%= adr.street "123 Main St" %>.
  #   <% end %>
  #
  def vaddress(opts = {}, &block)
    address = Microformats::Address.new(self)
    address.run(opts, &block)
  end

  # Creates a vEvent with the given options and a block.
  #
  # OPTIONS:
  # :tag - The HTML wrapper element (defaults to :div)
  # Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% vevent :id => 'my_event' do |event| %>
  #     This event is called <%= event.name "Cool Event" %>.
  #   <% end %>
  #
  def vevent(opts = {}, &block)
    event = Microformats::Event.new(self)
    event.run(opts, &block)
  end

  # Creates a vCalendar with the given options and a block.
  #
  # OPTIONS:
  # :tag - The HTML wrapper element (defaults to :div)
  # Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% vcalendar :id => 'my_cal' do |cal| %>
  #     <% cal.event :id => 'my_event' do |event| %>
  #       This event is called <%= event.name "Cool Event" %>.
  #     <% end %>
  #   <% end %>
  #
  def vcalendar(opts = {}, &block)
    cal = Microformats::Calendar.new(self)
    cal.run(opts, &block)
  end
end
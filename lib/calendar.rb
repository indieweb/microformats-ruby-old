class Microformats::Calendar
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  # You can directly initialize and run this class, but it's easier
  # to use the Microformats::Helpers#vcalendar helper method.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :div)
  # * Any other passed options will be treated as HTML attributes.
  #
  def run(opts = {}, &block)
    opts[:class] = combine_class_names('vcalendar', opts[:class])
    opts[:tag] ||= :div
    concat_tag(opts) do
      block.call(self)
    end
  end

  # Creates a vEvent with the given options and a block.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :div)
  # * Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% calendar.event :id => 'my_event' do |event| %>
  #     This event is called <%= event.name "Cool Event" %>.
  #   <% end %>
  #
  def event(opts = {}, &block)
    ev = Microformats::Event.new(@template)
    opts[:class] = combine_class_names('vevent', opts[:class])
    ev.run(opts, &block)
  end
end
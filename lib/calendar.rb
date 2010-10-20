class Microformats::Calendar
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  def run(opts = {}, &block)
    opts[:class] = combine_class_names('vcalendar', opts[:class])
    opts[:tag] ||= :div
    concat_tag(opts) do
      block.call(self)
    end
  end

  def event(opts = {}, &block)
    ev = Microformats::Event.new(@template)
    opts[:class] = combine_class_names('vevent', opts[:class])
    ev.run(opts, &block)
  end
end
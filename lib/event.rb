class Microformats::Event
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  def run(opts = {}, &block)
    opts[:class] = combine_class_names('vevent', opts[:class])
    opts[:itemscope] = 'itemscope'
    opts[:itemtype] = 'http://data-vocabulary.org/Event'
    opts[:tag] ||= :div
    concat_tag(opts) do
      block.call(self)
    end
  end

  def name(str, opts={})
    content_tag(str, merge_html_attrs({:itemprop => 'summary', :class => 'summary'}, opts))
  end

  def url(str, opts = {})
    if opts[:href]
      content_tag(str, merge_html_attrs({:tag => :a, :class => 'url', :itemprop => 'url'}, opts))
    elsif opts[:tag]
      content_tag(str, merge_html_attrs({:class => 'url', :itemprop => 'url'}, opts))
    else
      content_tag(str, merge_html_attrs({:tag => :a, :class => 'url', :href => str, :itemprop => 'url'}, opts))
    end
  end

  def photo(str, opts = {})
    if size = opts.delete(:size)
      opts[:width], opts[:height] = size.split('x')
    end
    content_tag(nil, merge_html_attrs({:tag => :img, :class => 'photo', :itemprop => 'photo', :src => str}, opts))
  end

  def description(str, opts={})
    content_tag(str, merge_html_attrs({:itemprop => 'description', :class => 'description'}, opts))
  end

  def starts_at(time_or_str, opts={})
    if time_or_str.is_a?(String)
      time = Time.parse(time_or_str)
      encoded_time = encode_time(time)
      humanized_time = opts.delete(:text) || time_or_str
    else
      encoded_time = encode_time(time_or_str)
      humanized_time = opts.delete(:text) || humanize_time(time_or_str)
    end
    inner_span = content_tag('', :class => 'value-title', :title => encoded_time)
    content_tag(inner_span + humanized_time, merge_html_attrs({:tag => :time, :itemprop => 'startDate', :class => 'dtstart', :datetime => encoded_time}, opts))
  end

  def ends_at(time_or_str, opts={})
    if time_or_str.is_a?(String)
      time = Time.parse(time_or_str)
      encoded_time = encode_time(time)
      humanized_time = opts.delete(:text) || time_or_str
    else
      encoded_time = encode_time(time_or_str)
      humanized_time = opts.delete(:text) || humanize_time(time_or_str)
    end
    inner_span = content_tag('', :class => 'value-title', :title => encoded_time)
    content_tag(inner_span + humanized_time, merge_html_attrs({:tag => :time, :itemprop => 'endDate', :class => 'dtend', :datetime => encoded_time}, opts))
  end

  def category(str, opts = {})
    content_tag(str, merge_html_attrs({:itemprop => 'eventType', :class => 'category'}, opts))
  end

  def location(opts = {}, &block)
    card = Microformats::Vcard.new(@template)
    opts[:class] = combine_class_names('location', opts[:class])
    card.run(opts, &block)
  end

end
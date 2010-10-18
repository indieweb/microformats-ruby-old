class Microformats::Event
  include Microformats::FormattingHelpers

  def name(str, opts={})
    content_tag(opts[:tag] || :span, str, :itemprop => 'summary', :class => 'summary')
  end

  def url(str, opts = {})
    if opts[:href]
      content_tag(:a, str, :href => opts[:href], :class => 'url', :itemprop => 'url')
    elsif opts[:tag]
      content_tag(opts[:tag], str, :class => 'url', :itemprop => 'url')
    else
      content_tag(:a, str, :class => 'url', :href => str, :itemprop => 'url')
    end
  end

  def photo(str, opts = {})
    image_tag(str, opts.merge(:itemprop => 'photo'))
  end

  def description(str, opts={})
    content_tag(opts[:tag] || :span, str, :itemprop => 'description', :class => 'description')
  end

  def starts_at(time_or_str, opts={})
    if time_or_str.is_a?(String)
      time = Time.parse(time_or_str)
      encoded_time = encode_time(time_or_str)
      humanized_time = opts[:text] || time_or_str
    else
      encoded_time = encode_time(time_or_str)
      humanized_time = opts[:text] || humanize_time(time_or_str)
    end
    inner_span = content_tag(:span, '', :class => 'value-title', :title => encoded_time)
    content_tag(opts[:tag] || :time, inner_span + humanized_time, :itemprop => 'startDate', :class => 'dtstart', :datetime => encoded_time)
  end

  def ends_at(time_or_str, opts={})
    if time_or_str.is_a?(String)
      time = Time.parse(time_or_str)
      encoded_time = encode_time(time_or_str)
      humanized_time = opts[:text] || time_or_str
    else
      encoded_time = encode_time(time_or_str)
      humanized_time = opts[:text] || humanize_time(time_or_str)
    end
    inner_span = content_tag(:span, '', :class => 'value-title', :title => encoded_time)
    content_tag(opts[:tag] || :time, inner_span + humanized_time, :itemprop => 'endDate', :class => 'dtend', :datetime => encoded_time)
  end

  def category(str, opts = {})
    content_tag(opts[:tag] || :span, str, :itemprop => 'eventType', :class => 'category')
  end

end
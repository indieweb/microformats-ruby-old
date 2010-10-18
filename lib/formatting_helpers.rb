module Microformats::FormattingHelpers
  def content_tag(tag, content, opts={})
    attrs = opts.inject([]) do |out, tuple|
      k,v = tuple
      out << "#{k}='#{v}'"
    end
    attr_string = attrs.sort.join(' ')
    open_tag = attr_string == '' ? tag : "#{tag} #{attr_string}"
    if [:img].include?(tag)
      "<#{open_tag} />"
    else
      "<#{open_tag}>#{content}</#{tag}>"
    end
  end

  def image_tag(src, opts={})
    if size = opts.delete(:size)
      opts[:width], opts[:height] = size.split('x')
    end
    opts[:src] = src
    content_tag(:img, nil, opts)
  end

  def encode_time(t)
    t.strftime("%Y-%m-%dT%H:%M%z").gsub(/00$/, ":00")
  end

  def humanize_time(t)
    t.strftime("%b %d, %Y at %I:%M%p").gsub(/\s0/, ' ')
  end
end
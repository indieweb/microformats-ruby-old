class Microformats::Event

  def name(str, opts={})
    content_tag(opts[:tag] || :span, str, :itemprop => 'summary')
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
end
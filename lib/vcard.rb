class Microformats::Vcard
  def initialize
    @default_tag = :span
  end

  def name(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'fn', :itemprop => 'name')
  end

  def company(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'org', :itemprop => 'affiliation')
  end
  alias_method :organization, :company

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

  def phone(str, opts = {})
    type = if opts[:type].to_s != ''
      type_inner_span = content_tag(:span, '', :class => 'value-title', :title => opts[:type])
      content_tag(:span, type_inner_span, :class => 'type')
    else
      ''
    end
    content_tag(opts[:tag] || :span, type + str, :class => 'tel')
  end

  def email(str, opts = {})
    type = if opts[:type].to_s != ''
      type_inner_span = content_tag(:span, '', :class => 'value-title', :title => opts[:type])
      content_tag(:span, type_inner_span, :class => 'type')
    else
      ''
    end
    if opts[:tag] == :a
      content_tag(:a, type + str, :class => 'email', :href => "mailto:#{str}")
    else
      content_tag(opts[:tag] || :span, type + str, :class => 'email')
    end
  end

  def download_link(url, opts = {})
    str = opts.delete(:text) || "Download vCard"
    new_url = "http://h2vx.com/vcf/" + url.gsub("http://", '')
    content_tag(:a, str, :href => new_url, :type => 'text/directory')
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

  def image_tag(src, opts={})
    if size = opts.delete(:size)
      opts[:width], opts[:height] = size.split('x')
    end
    opts[:src] = src
    content_tag(:img, nil, opts)
  end
end
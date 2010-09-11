class Microformats::Vcard
  def initialize
    @default_tag = :span
  end

  def name(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'fn')
  end

  def company(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'org')
  end
  alias_method :organization, :company

  def url(str, opts = {})
    if opts[:href]
      content_tag(:a, str, :href => opts[:href], :class => 'url')
    elsif opts[:tag]
      content_tag(opts[:tag], str, :class => 'url')
    else
      content_tag(:a, str, :class => 'url', :href => str)
    end
  end

  def phone(str, opts = {})
    type = opts[:type] ? content_tag(:span, opts[:type], :class => 'type') + ' ' : ''
    content_tag(opts[:tag] || :span, type + str, :class => 'tel')
  end

  def email(str, opts = {})
    type = opts[:type] ? content_tag(:span, opts[:type], :class => 'type') + ' ' : ''
    if opts[:tag] == :a
      content_tag(:a, type + str, :class => 'email', :href => "mailto:#{str}")
    else
      content_tag(opts[:tag] || :span, type + str, :class => 'email')
    end
  end

  private

  def content_tag(tag, content, opts={})
    attrs = opts.inject([]) do |out, tuple|
      k,v = tuple
      out << "#{k}='#{v}'"
    end
    attr_string = attrs.sort.join(' ')
    open_tag = attr_string == '' ? tag : "#{tag} #{attr_string}"
    "<#{open_tag}>#{content}</#{tag}>"
  end

end
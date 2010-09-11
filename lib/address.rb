class Microformats::Address
  def street(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'street-address')
  end

  def city(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'locality')
  end

  def state(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'region')
  end

  def zip(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'postal-code')
  end
  alias_method :postal_code, :zip

  def country(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'country-name')
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
module Microformats::FormattingHelpers
  def content_tag(content, opts={})
    tag = opts.delete(:tag) || @default_tag
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

  def concat_tag(opts={})
    tag = opts.delete(:tag) || @default_tag
    attrs = opts.inject([]) do |out, tuple|
      k,v = tuple
      out << "#{k}='#{v}'"
    end
    attr_string = attrs.sort.join(' ')
    open_tag = attr_string == '' ? tag : "#{tag} #{attr_string}"
    concat "<#{open_tag}>\n"
    yield
    concat "</#{tag}>\n"
  end

  def merge_html_attrs(base_attrs, overriding_attrs)
    classes = [base_attrs.delete(:class), overriding_attrs.delete(:class)].flatten.compact.sort.join(' ')
    attrs = base_attrs.merge(overriding_attrs)
    attrs[:class] = classes unless classes == '' # [].join #=> ''
    attrs
  end

  def concat(str)
    @template.concat(str)
  end

  def encode_time(t)
    t.strftime("%Y-%m-%dT%H:%M%z").gsub(/00$/, ":00")
  end

  def humanize_time(t)
    t.strftime("%b %d, %Y at %I:%M%p").gsub(/\s0/, ' ')
  end
end
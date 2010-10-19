class Microformats::Address
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  def run(opts = {}, &block)
    type = opts[:type] ? self.type(opts.delete(:type)) : nil
    opts[:class] = ['adr', opts[:class]].flatten.compact.sort.join(' ')
    opts[:itemscope] = 'itemscope'
    opts[:itemtype] = 'http://data-vocabulary.org/Address'
    opts[:tag] ||= :div
    concat_tag(opts) do
      concat type if type
      block.call(self)
    end
  end

  def type(str, opts = {})
    inner = content_tag('', :class => 'value-title', :title => str)
    content_tag(inner, merge_html_attrs({:class => 'type'}, opts))
  end

  def street(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'street-address', :itemprop => 'street-address'}, opts))
  end

  def city(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'locality', :itemprop => 'locality'}, opts))
  end

  def state(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'region', :itemprop => 'region'}, opts))
  end

  def zip(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'postal-code', :itemprop => 'postal-code'}, opts))
  end
  alias_method :postal_code, :zip

  def country(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'country-name', :itemprop => 'country-name'}, opts))
  end

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
    attrs[:class] = classes
    attrs
  end

end
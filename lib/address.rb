class Microformats::Address
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
  end

  def run(opts = {}, &block)
    type = opts[:type] ? self.type(opts[:type]) : nil
    concat "<div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>\n"
    concat type if type
    block.call(self)
    concat "</div>\n"
  end

  def type(str, opts = {})
    inner = content_tag(:span, '', :class => 'value-title', :title => str)
    content_tag(:span, inner, :class => 'type')
  end

  def street(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'street-address', :itemprop => 'street-address')
  end

  def city(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'locality', :itemprop => 'locality')
  end

  def state(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'region', :itemprop => 'region')
  end

  def zip(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'postal-code', :itemprop => 'postal-code')
  end
  alias_method :postal_code, :zip

  def country(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'country-name', :itemprop => 'country-name')
  end

end
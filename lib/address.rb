class Microformats::Address
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  # You can directly initialize and run this class, but it's easier
  # to use the Microformats::Helpers#vaddress helper method or the
  # Microformats::Vcard#address method.
  #
  # OPTIONS:
  # * :type - A string that specifies the type of address('home', 'work', etc)
  # * :tag - The HTML wrapper element (defaults to :div)
  # * Any other passed options will be treated as HTML attributes.
  #
  def run(opts = {}, &block)
    type = opts[:type] ? self.type(opts.delete(:type)) : nil
    opts[:class] = combine_class_names('adr', opts[:class])
    opts[:itemscope] = 'itemscope'
    opts[:itemtype] = 'http://data-vocabulary.org/Address'
    opts[:tag] ||= :div
    concat_tag(opts) do
      concat type if type
      block.call(self)
    end
  end

  # Outputs markup for the type of address ('work', 'home', etc.)
  # There will be no visible text unless provided with the :text option.
  #
  # <em>NOTE: You get this for free with the :type option of
  # Microformats::Helpers#vaddress, Microformats::Vcard#address and #run methods.</em>
  #
  # OPTIONS
  # * :text - String, the text you want displayed as a text node (default is '')
  # * Any other passed options will be treated as HTML attributes.
  #
  def type(str, opts = {})
    inner = content_tag('', :class => 'value-title', :title => str)
    text = opts.delete(:text) || ''
    content_tag(inner + text, merge_html_attrs({:class => 'type'}, opts))
  end

  # Outputs the passed string as a street address.
  #
  # OPTIONS
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def street(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'street-address', :itemprop => 'street-address'}, opts))
  end

  # Outputs the passed string as a city.
  #
  # OPTIONS
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def city(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'locality', :itemprop => 'locality'}, opts))
  end

  # Outputs the passed string as a state.
  #
  # OPTIONS
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def state(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'region', :itemprop => 'region'}, opts))
  end

  # Outputs the passed string as a postal code.
  #
  # OPTIONS
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def zip(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'postal-code', :itemprop => 'postal-code'}, opts))
  end
  alias_method :postal_code, :zip

  # Outputs the passed string as a country.
  #
  # OPTIONS
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def country(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'country-name', :itemprop => 'country-name'}, opts))
  end

end
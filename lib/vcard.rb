class Microformats::Vcard
  include Microformats::FormattingHelpers

  # You can directly initialize and runthis class, but it's easier
  # to use the Microformats::Helpers#vcard helper method.
  def initialize(template)
    @template = template
    @default_tag = :span
  end

  # You can directly initialize and runthis class, but it's easier
  # to use the Microformats::Helpers#vcard helper method.
  def run(opts = {}, &block)
    opts[:class] = combine_class_names('vcard', opts[:class])
    opts[:itemscope] = 'itemscope'
    opts[:itemtype] = 'http://data-vocabulary.org/Person'
    opts[:tag] ||= :div
    concat_tag(opts) do
      block.call(self)
    end
  end

  # Marks up a person's name.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def name(str, opts = {})
    content_tag(str, merge_html_attrs({:class => 'fn', :itemprop => 'name'}, opts))
  end

  # Marks up a company name. If this vCard represents a company
  # rather than an individual person that works at a company, set
  # the :is_company option to true.
  #
  # OPTIONS:
  # * :is_company - Boolean, true if this is a company vCard (defaults to false)
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def company(str, opts = {})
    classes = opts.delete(:is_company) ? 'fn org' : 'org'
    content_tag(str, merge_html_attrs({:class => classes, :itemprop => 'affiliation'}, opts))
  end
  alias_method :organization, :company

  # Marks up the person's URL. By default, it will output an <a> tag using
  # the passed in string as both the href and the text. If the :href option
  # is passed, then the string argument is treated as text.
  #
  # OPTIONS:
  # * :href - If passed, the string argument will be treated as the text node.
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLES:
  #   card.url('http://google.com') #=> <a class='url' href='http://google.com' itemprop='url'>http://google.com</a>
  #   card.url('Google', :href => 'http://google.com') #=> <a class='url' href='http://google.com' itemprop='url'>Google</a>
  #   card.url('http://google.com', :tag => :span) #=> <span class='url' itemprop='url'>http://google.com</span>
  #
  def url(str, opts = {})
    if opts[:href]
      content_tag(str, merge_html_attrs({:tag => :a, :class => 'url', :itemprop => 'url'}, opts))
    elsif opts[:tag]
      content_tag(str, merge_html_attrs({:class => 'url', :itemprop => 'url'}, opts))
    else
      content_tag(str, merge_html_attrs({:tag => :a, :class => 'url', :href => str, :itemprop => 'url'}, opts))
    end
  end

  # Marks up the vCard photo as an <img> tag. Takes the image URL as the first argument.
  #
  # OPTIONS
  # * :size - Pass a string with WIDTHxHEIGHT like "200x100" in lieu of the :width and :height options.
  # * Any other passed options will be treated as HTML attributes.
  #
  def photo(str, opts = {})
    if size = opts.delete(:size)
      opts[:width], opts[:height] = size.split('x')
    end
    content_tag(nil, merge_html_attrs({:tag => :img, :class => 'photo', :itemprop => 'photo', :src => str}, opts))
  end

  # Marks up a phone number, takes the phone number as a string.
  #
  # OPTIONS
  # * :type - A string that specifies the type of phone number ('home', 'work', etc)
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def phone(str, opts = {})
    type = if opts[:type].to_s != ''
      type_inner_span = content_tag('', :class => 'value-title', :title => opts.delete(:type))
      content_tag(type_inner_span, :class => 'type')
    else
      ''
    end
    content_tag(type + str, merge_html_attrs({:class => 'tel'}, opts))
  end

  # Marks up an email address, takes the email as a string.
  #
  # OPTIONS
  # * :type - A string that specifies the type of phone number ('home', 'work', etc)
  # * :tag - The HTML wrapper element (defaults to :a)
  # * Any other passed options will be treated as HTML attributes.
  #
  def email(str, opts = {})
    opts[:tag] ||= :a
    type = if opts[:type].to_s != ''
      type_inner_span = content_tag('', :class => 'value-title', :title => opts.delete(:type))
      content_tag(type_inner_span, :class => 'type')
    else
      ''
    end
    if opts[:tag] == :a
      content_tag(type + str, merge_html_attrs({:class => 'email', :href => "mailto:#{str}"}, opts))
    else
      content_tag(type + str, merge_html_attrs({:class => 'email'}, opts))
    end
  end

  # Accepts latitude and longitude as arguments. It will only output a
  # visible text node if you provide the :text option.
  #
  # OPTIONS
  # * :text - String, the text will be be displayed inside the 'geo' wrapper
  #
  def coordinates(lat, lng, opts = {})
    lat_meta = content_tag('', :tag => :meta, :itemprop => 'latitude', :content => lat)
    lng_meta = content_tag('', :tag => :meta, :itemprop => 'longitude', :content => lng)
    lat_span = content_tag(content_tag('', :class => 'value-title', :title => lat), :class => 'latitude')
    lng_span = content_tag(content_tag('', :class => 'value-title', :title => lng), :class => 'longitude')
    text = opts[:text] || ''
    content_tag(lat_meta + lng_meta + lat_span + lng_span + text, :class => 'geo', :itemprop => 'geo', :itemscope => 'itemscope', :itemtype => 'http://data-vocabulary.org/Geo')
  end

  # Outputs a link to h2vx.com that will let the user download the vcard
  # at the passed URL.
  #
  # OPTIONS
  # * :text - The link text (default is "Download vCard")
  # * Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE
  #   <%# In Rails, request.request_uri returns the URL of this page %>
  #   <%= card.download_link request.request_uri %>
  #
  def download_link(url, opts = {})
    str = opts.delete(:text) || "Download vCard"
    new_url = "http://h2vx.com/vcf/" + url.gsub("http://", '')
    content_tag(str, merge_html_attrs({:tag => :a, :href => new_url, :type => 'text/directory'}, opts))
  end

  # Opens a new block for a nested vAddress.
  #
  # OPTIONS:
  # * :type - A string that specifies the type of address('home', 'work', etc)
  # * :tag - The HTML wrapper element (defaults to :div)
  # * Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% card.address :type => 'work', :id => 'my_adr' do |adr| %>
  #     I live at <%= adr.street "123 Main St" %>.
  #   <% end %>
  #
  def address(opts = {}, &block)
    adr = Microformats::Address.new(@template)
    adr.run(opts, &block)
  end
end
class Microformats::Vcard
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  def run(opts = {}, &block)
    opts[:class] = ['vcard', opts[:class]].flatten.compact.sort.join(' ')
    opts[:itemscope] = 'itemscope'
    opts[:itemtype] = 'http://data-vocabulary.org/Person'
    concat_tag(opts[:tag] || :div, opts) do
      block.call(self)
    end
  end

  def name(str, opts = {})
    content_tag(opts[:tag] || :span, str, :class => 'fn', :itemprop => 'name')
  end

  def company(str, opts = {})
    classes = opts.delete(:is_company) ? 'fn org' : 'org'
    content_tag(opts[:tag] || :span, str, :class => classes, :itemprop => 'affiliation')
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

  def coordinates(lat, lng, opts = {})
    # <span class='geo' itemprop='geo' itemscope='itemscope' itemtype='http://data-vocabulary.org/Geo'>
    # <meta content='37.774929' itemprop='latitude'></meta>
    # <meta content='-122.419416' itemprop='longitude'></meta>
    # <span class='latitude'><span class='value-title' title='37.774929'></span></span>
    # <span class='longitude'><span class='value-title' title='-122.419416'></span></span>
    # </span>
    lat_meta = content_tag(:meta, '', :itemprop => 'latitude', :content => lat)
    lng_meta = content_tag(:meta, '', :itemprop => 'longitude', :content => lng)
    lat_span = content_tag(:span, content_tag(:span, '', :class => 'value-title', :title => lat), :class => 'latitude')
    lng_span = content_tag(:span, content_tag(:span, '', :class => 'value-title', :title => lng), :class => 'longitude')
    text = opts[:text] || ''
    content_tag(:span, lat_meta + lng_meta + lat_span + lng_span + text, :class => 'geo', :itemprop => 'geo', :itemscope => 'itemscope', :itemtype => 'http://data-vocabulary.org/Geo')
  end

  def download_link(url, opts = {})
    str = opts.delete(:text) || "Download vCard"
    new_url = "http://h2vx.com/vcf/" + url.gsub("http://", '')
    content_tag(:a, str, :href => new_url, :type => 'text/directory')
  end

end
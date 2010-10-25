class Microformats::Event
  include Microformats::FormattingHelpers

  def initialize(template)
    @template = template
    @default_tag = :span
  end

  # You can directly initialize and run this class, but it's easier
  # to use the Microformats::Helpers#vevent helper method or the
  # Microformats::Calendar#event method.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :div)
  # * Any other passed options will be treated as HTML attributes.
  #
  def run(opts = {}, &block)
    opts[:class] = combine_class_names('vevent', opts[:class])
    opts[:itemscope] = 'itemscope'
    opts[:itemtype] = 'http://data-vocabulary.org/Event'
    opts[:tag] ||= :div
    concat_tag(opts) do
      block.call(self)
    end
  end

  # Marks up an event's name.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def name(str, opts={})
    content_tag(str, merge_html_attrs({:itemprop => 'summary', :class => 'summary'}, opts))
  end

  # Marks up the event's URL. By default, it will output an <a> tag using
  # the passed in string as both the href and the text. If the :href option
  # is passed, then the string argument is treated as text.
  #
  # OPTIONS:
  # * :href - If passed, the string argument will be treated as the text node.
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLES:
  #   event.url('http://google.com') #=> <a class='url' href='http://google.com' itemprop='url'>http://google.com</a>
  #   event.url('Google', :href => 'http://google.com') #=> <a class='url' href='http://google.com' itemprop='url'>Google</a>
  #   event.url('http://google.com', :tag => :span) #=> <span class='url' itemprop='url'>http://google.com</span>
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

  # Marks up the event photo as an <img> tag. Takes the image URL as the first argument.
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

  # Marks up an event's description.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def description(str, opts={})
    content_tag(str, merge_html_attrs({:itemprop => 'description', :class => 'description'}, opts))
  end

  # Marks up the event's start time/date. Accepts either a Time object
  # or a time String as the first argument. By default, the text node
  # will be the date and time output like "Oct 20, 2010 at 7:30PM", but
  # this can be overridden by the :text option.
  #
  # OPTIONS:
  # * :text - String, will be displayed as the text node.
  # * Any other passed options will be treated as HTML attributes.
  #
  def starts_at(time_or_str, opts={})
    if time_or_str.is_a?(String)
      time = Time.parse(time_or_str)
      encoded_time = encode_time(time)
      humanized_time = opts.delete(:text) || time_or_str
    else
      encoded_time = encode_time(time_or_str)
      humanized_time = opts.delete(:text) || humanize_time(time_or_str)
    end
    inner_span = content_tag('', :class => 'value-title', :title => encoded_time)
    content_tag(inner_span + humanized_time, merge_html_attrs({:tag => :time, :itemprop => 'startDate', :class => 'dtstart', :datetime => encoded_time}, opts))
  end

  # Marks up the event's end time/date. Accepts either a Time object
  # or a time String as the first argument. By default, the text node
  # will be the date and time output like "Oct 20, 2010 at 7:30PM", but
  # this can be overridden by the :text option.
  #
  # OPTIONS:
  # * :text - String, will be displayed as the text node.
  # * Any other passed options will be treated as HTML attributes.
  #
  def ends_at(time_or_str, opts={})
    if time_or_str.is_a?(String)
      time = Time.parse(time_or_str)
      encoded_time = encode_time(time)
      humanized_time = opts.delete(:text) || time_or_str
    else
      encoded_time = encode_time(time_or_str)
      humanized_time = opts.delete(:text) || humanize_time(time_or_str)
    end
    inner_span = content_tag('', :class => 'value-title', :title => encoded_time)
    content_tag(inner_span + humanized_time, merge_html_attrs({:tag => :time, :itemprop => 'endDate', :class => 'dtend', :datetime => encoded_time}, opts))
  end

  # Marks up an event's category name.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :span)
  # * Any other passed options will be treated as HTML attributes.
  #
  def category(str, opts = {})
    content_tag(str, merge_html_attrs({:itemprop => 'eventType', :class => 'category'}, opts))
  end

  # Creates a vCard with the given options and a block to represent
  # the event's location.
  #
  # OPTIONS:
  # * :tag - The HTML wrapper element (defaults to :div)
  # * Any other passed options will be treated as HTML attributes.
  #
  # EXAMPLE:
  #   <% event.location :id => 'my_location' do |card| %>
  #     We will be meeting at the <%= card.company "Obtiva" %> office.
  #   <% end %>
  #
  def location(opts = {}, &block)
    card = Microformats::Vcard.new(@template)
    opts[:class] = combine_class_names('location', opts[:class])
    card.run(opts, &block)
  end

end
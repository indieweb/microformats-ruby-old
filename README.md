# Microformats

**STILL IN DEVELOPMENT, IT SHOULD WORK, BUT USE AT YOUR OWN RISK!**

_Created by Chris Powers, September 11, 2010_

## Two Great Tastes, One Great Library

The goal of this Microformats library is to give the developer
a series of simple view helper methods to richly markup their
HTML documents using both the older Microformats standard and
the new HTML5 Microdata standard.

By using microformats, you are opening your data up to Google
and other consumers for easy and intelligent consumption. In
the future, Google plans on making consumed microdata
directly searchable, which yields all sorts of new potential
for relevant results.

## Installation

Install the Microformats gem as usual:

```
gem install microformats
```

## Getting Started

To use Microformats, first include the Microformats::Helper
mixin into your view layer, like this in Rails:

```
# in app/helpers/application_helper.rb
module Application Helper
  include Microformats::Helpers
end
```

## Usage: vCards and Addresses

You can easily markup a person and/or organization using the
`vcard` helper method. This will use both the hCard Microformat
and the http://www.data-vocabulary.org/Person microdata.

**PLEASE NOTE:** These two microdata standards do
not support the same fields. For example, hCard gives a person
telephone numbers and email addresses. The Person microdata only
gives organizations a single telephone number and has no support
for email.

vCards can embed addresses using the Microformats::Vcard#address
method, which gives you a block to run with a new
Microformats::Address object.

EXAMPLE (using ERB):

```
<% vcard do |card| %>
  <%= card.photo "/images/me.jpg", :size => '200x300' %>
  <%= card.name "John Doe" %>
  <%= card.url "Visit my Site", :href => "http://mydomain.com" %>
  <%= card.phone "999.888.7766", :type => 'Home' %>
  <%= card.phone "111.222.3344", :type => 'Work' %>
  <%= card.email "me@mydomain.com", :type => 'Home' %>

  I work at <%= card.company "Acme Co." %>
  <% card.address(:type => 'Work') do |adr| %>
    <%= adr.street "123 Main" %>
    <%= adr.city "Chicago" %>, <%= adr.state 'IL' %> <%= adr.zip '60010' %>
  <% end %>
  <%= card.download_link "http://mydomain.com" %>
<% end %>
```

This will output the following markup:

```
<div class='vcard' itemscope='itemscope' itemtype='http://data-vocabulary.org/Person'>
  <img class='photo' itemprop='photo' src='/images/me.jpg' width='200' height='300' />
  <span class='fn' itemprop='name'>John Doe</span>
  <a class='url' href='http://mydomain.com' itemprop='url'>Visit my Site</a>
  <span class='tel'><span class='type'><span class='value-title' title='Home'></span></span>999.888.7766</span>
  <span class='tel'><span class='type'><span class='value-title' title='Work'></span></span> 111.222.3344</span>
  <a class='email' href='mailto:me@mydomain.com'><span class='value-title' title='Home'></span>me@mydomain.com</span>

  I work at <span class='org' itemprop='affiliation'>Acme Co.</span>
  <div class='adr' itemscope='itemscope' itemtype='http://data-vocabulary.org/Address'>
    <span class='type'><span class='value-title' title='Work'></span></span>
    <span class='street-address' itemprop='street-address'>123 Main</span>
    <span class='locality' itemprop='locality'>Chicago</span>, <span class='region' itemprop='region'>IL</span> <span class='postal-code' itemprop='postal-code'>60010</span>
  </div>
  <a href='http://h2vx.com/vcf/mydomain.com/page' type='text/directory'>Download vCard</a>
</div>
```

While these helper methods default to using `<span>` tags
(and `<a>` tags as appropriate), you can easily customize
the tag used for any given piece of microdata by using the
`:tag` option:

```
<%= card.name "John Doe", :tag => :h1 %>
```

Also note that you get the `download_link` method
that builds a link to h2vx.com that will automatically let
the user download vCards from whatever page url you pass in.
Usually you will just want to pass in the page that you are
currently on, so this is a quick way to do this in Rails:

```
<%= card.download_link request.request_uri %>
```

## Usage: Calendars and Events

Calendars with many events can be represented using the
Microformats::Calendar and Microformats::Event classes.
This employs the hCal and hEvent microformats along with the
http://www.data-vocabulary.org/Event microdata.

**NOTE:** An Event can use a nested vCard to represent
its location information.

EXAMPLE:

```
<% vcalendar :id => "my_calendar" do |cal| %>
  <h1>Upcoming Events</h1>
  <% cal.event do |event| %>
    <h2><%= event.url(event.name("Happy Hour"), :href => "http://meetup.com/happyhour") %></h2>
    <%= event.photo "/images/happy_hour.jpg", :size => "250x150" %>
    <%= event.description "Come hang out with us for half price drinks at lots of fun!" %>
    <span class='time_range'>
      From <%= event.starts_at "October 30, 2010 at 7:30PM" %> -
      <%= event.ends_at "October 30, 2010 at 10:00PM", :text => "10:00PM" %>
    </span>
    <% event.location do |card| %>
      <%= card.url(card.company("Frank's Bar", :is_company => true), :href => "http://franksbar.com") %>
      <% card.address do |adr| %>
        <%= adr.street "784 N Main St" %><br />
        <%= adr.city "Chicago" %>, <%= adr.state "IL" %> <%= adr.zip "60016" %>
      <% end %>
    <% end %>
  <% end %>
  <!-- More events could be added... -->
<% end %>
```

## Resources

* http://www.data-vocabulary.org
* http://microformats.org

## Care to Help?

There are still a lot of standards that need to be implemented into
this library, including but not limited to: Events, Products, Reviews,
Organizations. I will continue to work on these, but I'd be happy to
accept pull requests!

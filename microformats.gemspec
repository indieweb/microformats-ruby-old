Gem::Specification.new do |s|
  s.name = 'microformats'
  s.version = '0.3'
  s.author = 'Chris Powers'
  s.date = "2010-09-11"
  s.homepage = 'http://github.com/chrisjpowers/microformats'
  s.email = 'chrisjpowers@gmail.com'
  s.summary = 'The Microformats gem gives you helper methods for richly marking up your HTML with microformats and HTML5 microdata.'
  s.files = [ 'README.rdoc', 'CHANGELOG.rdoc', 'LICENSE', 'Rakefile', 'lib/address.rb',
              'lib/calendar.rb', 'lib/event.rb', 'lib/formatting_helpers.rb',
              'lib/helpers.rb', 'lib/microformats.rb', 'lib/vcard.rb']
  s.require_paths = ["lib"]
  s.has_rdoc = true
end

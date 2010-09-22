Gem::Specification.new do |s|
  s.name = 'microformats'
  s.version = '0.1'
  s.author = 'Chris Powers'
  s.date = "2010-09-11"
  s.homepage = 'http://github.com/chrisjpowers/microformats'
  s.email = 'chrisjpowers@gmail.com'
  s.summary = 'The Microformats gem gives you helper methods for richly marking up your HTML with microformats and HTML5 microdata.'
  s.files = [ 'README.rdoc', 'CHANGELOG.rdoc', 'LICENSE', 'Rakefile', 'lib/microformats.rb',
              'lib/address.rb', 'lib/helpers.rb', 'lib/vcard.rb', 'spec/address_spec.rb',
              'spec/helpers_spec.rb', 'spec/spec_helper.rb', 'spec/vcard_spec.rb']
  s.require_paths = ["lib"]
  s.has_rdoc = true
end

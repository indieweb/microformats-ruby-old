require 'rubygems'
require 'rake'
require 'rake/rdoctask'
# require 'rake/gempackagetask'
# require 'rcov/rcovtask'
# require 'date'

require 'spec/rake/spectask'

desc 'Default: run the specs.'
task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.warning = true
end

namespace :doc do
  task :default => :gem

  desc "Generate documentation for the gem."
  Rake::RDocTask.new("gem") { |rdoc|
    rdoc.rdoc_dir = 'doc'
    # rdoc.template = ENV['template'] if ENV['template']
    rdoc.title    = "Microformats"
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.options << '--charset' << 'utf-8'
    rdoc.rdoc_files.include('README.rdoc')
    rdoc.rdoc_files.include('lib/**/*.rb')
  }
end

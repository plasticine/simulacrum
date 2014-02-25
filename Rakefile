#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rdoc/task'

require 'bundler'
Bundler::GemHelper.install_tasks

desc 'Generate documentation for the Fever plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Fever'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

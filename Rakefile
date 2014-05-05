#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'cane/rake_task'
require 'rdoc/task'
require 'bundler'
Bundler::GemHelper.install_tasks

desc 'Generate documentation for the Simulacrum plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Simulacrum'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Run cane to check quality metrics'
Cane::RakeTask.new(:quality) do |cane|
  cane.canefile = '.cane'
end

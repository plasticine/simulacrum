#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rdoc/task'

require 'bundler'
Bundler::GemHelper.install_tasks

namespace :spec do
  require 'appraisal'

  begin
    require 'cane/rake_task'

    desc "Run cane to check quality metrics"
    Cane::RakeTask.new(:quality) do |cane|
      cane.abc_max = 10
      cane.add_threshold 'coverage/covered_percent', :>=, 87
      cane.no_style = true
    end

    task :default => :quality
  rescue LoadError
    warn "cane not available, quality task not provided."
  end

  desc 'Run specs'
  RSpec::Core::RakeTask.new(:unit) do |spec|
    spec.pattern = "spec/**/*_spec.rb"
    spec.rspec_opts = "--require spec_helper --format progress --colour"
  end

  desc 'Generate documentation for the nestive plugin.'
  Rake::RDocTask.new(:rdoc) do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title    = 'Nestive'
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.rdoc_files.include('README')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
end

desc 'Default: run unit tests.'
task :default => ['spec:unit']

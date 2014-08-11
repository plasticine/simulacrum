# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'simulacrum/version'

Gem::Specification.new do |gem|
  gem.name          = Simulacrum::PACKAGE
  gem.version       = Simulacrum::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.required_ruby_version = '>= 1.9.3'

  gem.authors       = ['Justin Morris']
  gem.email         = ['desk@pixelbloom.com']
  gem.homepage      = 'https://github.com/plasticine/simulacrum'
  gem.licenses      = ['MIT']
  gem.summary       =
    %q{A gem for visually testing and inspecting user interface components.}
  gem.description   = %q{
    An opinionated UI component regression testing tool built to be tightly
    integrated with RSpec, Selenium and tools you already use.
  }

  gem.required_ruby_version = '>= 1.9.3'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = Dir['spec/**/*']
  gem.require_paths = ['lib']
  gem.has_rdoc      = false
  gem.bindir        = 'exe'
  gem.executables   = ['simulacrum']

  gem.add_dependency 'capybara', ['~> 2.4.1']
  gem.add_dependency 'rmagick', '~> 2.13.2'
  gem.add_dependency 'rspec', ['>= 2.14.1']
  gem.add_dependency 'selenium-webdriver', ['~> 2.42.0']
  gem.add_dependency 'parallel', ['~> 1.2.0']
  gem.add_dependency 'retries'
  gem.add_dependency 'net-http-persistent'

  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'aruba'
  gem.add_development_dependency 'cane'
  gem.add_development_dependency 'codeclimate-test-reporter'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', ['~> 3.0.0']
  gem.add_development_dependency 'rubocop', ['~> 0.20.1']
  gem.add_development_dependency 'sauce', ['~> 3.4.8']
  gem.add_development_dependency 'sauce-connect', ['~> 3.4.1']
  gem.add_development_dependency 'sauce-cucumber', ['~> 3.4.0']
  gem.add_development_dependency 'shoulda-matchers'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'sinatra'
  gem.add_development_dependency 'dotenv'
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'simulacrum/version'

Gem::Specification.new do |s|
  s.name          = Simulacrum::PACKAGE
  s.version       = Simulacrum::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Justin Morris']
  s.email         = ['desk@pixelbloom.com']
  s.homepage      = 'https://github.com/plasticine/simulacrum'
  s.summary       = 'A gem for visually testing and inspecting user interface components.'
  s.description   = 'An opinionated UI component regression testing tool built to be tightly integrated with RSpec, Selenium and tools you already use.'
  s.licenses      = ['MIT']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ['lib']
  s.executables   = ['simulacrum']

  s.add_dependency 'curb', '~> 0.8.5'
  s.add_dependency 'parallel', '~> 1.0.0'
  s.add_dependency 'capybara', '~> 2.2.1'
  s.add_dependency 'rspec', '~> 2.14.1'
  s.add_dependency 'rmagick', '~> 2.13.2'
  s.add_dependency 'selenium-webdriver', '~> 2.40.0'

  s.add_development_dependency 'cane'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop', '~> 0.20.1'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'simplecov'
end

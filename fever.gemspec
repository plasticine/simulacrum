# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'Simulacrum/version'

Gem::Specification.new do |s|
  s.name          = Simulacrum::PACKAGE
  s.version       = Simulacrum::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Justin Morris']
  s.email         = ['desk@pixelbloom.com']
  s.homepage      = 'https://github.com/plasticine/Simulacrum'
  s.summary       = 'A gem for visually testing and inspecting user interface components.'
  s.description   = 'A gem for visually testing and inspecting user interface components.'
  s.licenses      = ['MIT']

  s.files         = Dir["{lib}/**/*", "README.md", "LICENSE"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ['lib']

  s.add_dependency 'capybara'
  s.add_dependency 'rspec'
  s.add_dependency 'rmagick'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-nc'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'simplecov'
end

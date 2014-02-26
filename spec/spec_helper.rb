if ENV['COVERAGE']
  require_relative 'use_coveralls' if ENV['TRAVIS']
  require_relative 'use_simplecov' unless ENV['TRAVIS']
end

require 'bundler/setup'
require 'Simulacrum'
require 'rspec/autorun'

RSpec.configure do |config|
  config.order = "random"
end

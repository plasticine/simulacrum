ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require_relative 'use_coveralls' if ENV['TRAVIS']
  require_relative 'use_simplecov' unless ENV['TRAVIS']
end

require 'bundler/setup'
require 'fever'

Combustion.initialize! :action_controller, :action_view, :sprockets

require 'rspec/autorun'

RSpec.configure do |config|
  config.order = "random"
end

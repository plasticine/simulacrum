require_relative 'use_simplecov'
require_relative 'use_codeclimate'

require 'bundler/setup'
require 'Simulacrum'
require 'rspec/autorun'

RSpec.configure do |config|
  config.order = 'random'
end

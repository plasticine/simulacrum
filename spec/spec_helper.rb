# encoding: UTF-8
require 'use_codeclimate'
require 'use_simplecov'
require 'use_coveralls' if ENV['COVERAGE']
require 'bundler/setup'
require 'simulacrum'

RSpec.configure do |config|
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# encoding: UTF-8
ENV['RAILS_ENV'] ||= 'test'
require 'use_codeclimate'
require 'use_simplecov'
require 'bundler/setup'
require 'simulacrum'

RSpec.configure do |config|
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.syntax = :expect
  end
end

# encoding: UTF-8
ENV['RAILS_ENV'] ||= 'test'
require 'use_codeclimate'
require 'use_simplecov'
require 'use_coveralls' if ENV['COVERAGE']
require 'bundler/setup'
require 'simulacrum'

RSpec.configure do |config|
  config.order = 'random'
end

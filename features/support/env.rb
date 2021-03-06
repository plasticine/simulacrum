# encoding: UTF-8
require 'aruba'
require 'aruba/cucumber'
require 'fileutils'
require 'dotenv'
Dotenv.load

ENV['PROJECT_ROOT_PATH'] = File.expand_path('../../../', __FILE__)

Dir.glob('features/step_definitions/**/*steps.rb') { |f| load f, true }

Before do
  @aruba_timeout_seconds = (ENV['CI']) ? 240 : 120
  @aruba_io_wait_seconds = (ENV['CI']) ? 240 : 120
end

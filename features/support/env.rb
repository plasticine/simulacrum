require 'capybara'
require 'aruba'
require 'aruba/cucumber'
require 'fileutils'

ENV['PROJECT_ROOT_PATH'] = File.expand_path('../../../', __FILE__)

Dir.glob('features/step_definitions/**/*steps.rb') { |f| load f, true }

Before do
  @aruba_timeout_seconds = 10
  @aruba_io_wait_seconds = 10
end

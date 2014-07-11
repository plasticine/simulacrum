require 'capybara'
require 'aruba'
require 'aruba/cucumber'
require 'fileutils'

if ENV['CI']
  require 'sauce'
  require 'sauce/capybara'

  Capybara.default_driver = :sauce

  Sauce.config do |sauce|
    sauce[:browsers] = [['Linux', 'Chrome', nil]]
  end
end

ENV['PROJECT_ROOT_PATH'] = File.expand_path('../../../', __FILE__)

Dir.glob('features/step_definitions/**/*steps.rb') { |f| load f, true }

Before do
  @aruba_timeout_seconds = 10
  @aruba_io_wait_seconds = 10
end

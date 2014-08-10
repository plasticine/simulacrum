# encoding: UTF-8
ENV['RAILS_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require './fixture_app'
require 'capybara'
require 'sauce/capybara'
require 'simulacrum'

Capybara.app = FixtureApp
Capybara.run_server = true
Capybara.app_host = "http://0.0.0.0:#{Capybara.server_port}"
Capybara.default_driver = :test_driver

# Defines a custom driver so that we can assume a predictable output dir
Capybara.register_driver :test_driver do |app|
  if ENV['CI']
    caps = Selenium::WebDriver::Remote::Capabilities.firefox
    caps.platform = 'Linux'
    caps.version = '31'
    url = "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub"
    Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
  else
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
end

Simulacrum.configure do |config|
  config.component.capture_selector = '#test-capture-selector'
  config.component.delta_threshold = 0.1  # allow for colour-space differences between platforms
end

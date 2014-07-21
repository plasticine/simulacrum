ENV['RAILS_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require './fixture_app'
require 'capybara'
require 'sauce/capybara'
require 'simulacrum'

Capybara.app = FixtureApp.new
Capybara.default_driver = :sauce
Capybara.run_server = true

Simulacrum.configure do |config|
  config.component.capture_selector = '#test-capture-selector'
end

Sauce.config do |config|
  config[:name] = 'Simulacrum'
  config[:start_tunnel] = false
  config[:start_local_application] = false
  config[:os] = 'Linux'
  config[:browser] = 'Chrome'
  config[:browser_version] = '35'
end

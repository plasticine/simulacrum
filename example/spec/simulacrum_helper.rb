require 'rspec'
require 'capybara'
require 'simulacrum'

RSpec.configure do |config|
  include Simulacrum

  Simulacrum.configure do |config|
    config.driver = Simulacrum::Driver::BrowserstackDriver.new(
      username: '1234abcd',
      api_key: '1234abcd'
    )
    config.defaults.acceptable_delta = 0.1
  end
end

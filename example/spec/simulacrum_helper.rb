require 'rspec'
require 'capybara'
require 'simulacrum'

RSpec.configure do |config|
  include Simulacrum

  Simulacrum.configure do |config|
    config.defaults.acceptable_delta = 0.1
  end
end

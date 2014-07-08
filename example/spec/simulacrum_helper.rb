require 'rspec'
require 'capybara'
require 'simulacrum'
require './example_app'

RSpec.configure do |config|
  include Simulacrum

  Capybara.app = ExampleApp

  Simulacrum.configure do |config|
    config.component.delta_threshold = 1 # 1% percentage change allowed
  end
end

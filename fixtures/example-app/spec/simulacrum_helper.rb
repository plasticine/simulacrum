require 'capybara'
require 'simulacrum'
require './example_app'

RSpec.configure do |config|
  include Simulacrum
  Capybara.app = ExampleApp
end

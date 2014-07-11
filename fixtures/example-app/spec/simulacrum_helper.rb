require 'capybara'
require 'simulacrum'
require './fixture_app'

RSpec.configure do |config|
  include Simulacrum
  Capybara.app = FixtureApp
end

require 'capybara'
require 'capybara/poltergeist'
require 'simulacrum'
require './fixture_app'

RSpec.configure do |config|
  include Simulacrum
  Capybara.default_driver = :poltergeist
  Capybara.app = FixtureApp
end

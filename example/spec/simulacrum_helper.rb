require 'capybara'
require 'simulacrum'
require './example_app'

Capybara.app = ExampleApp

Simulacrum.configure do |simulacrum|
  simulacrum.component.delta_threshold = 1.0 # 1.0% change allowed
end

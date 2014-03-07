require_relative '../../lib/simulacrum'
require 'selenium/webdriver'


RSpec.configure do |config|
  config.include Simulacrum

  Simulacrum.configure do |config|
    config.images_path = '/Users/justin/src/personal/Simulacrum/example/spec/ui_specs'
    config.acceptable_delta = 1 # allow a maximum of 1% difference
  end
end

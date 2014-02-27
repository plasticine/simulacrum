require_relative '../../lib/simulacrum'

RSpec.configure do |config|
  config.include Simulacrum

  Simulacrum.configure do |config|
    config.images_path = '/Users/justin/src/personal/Simulacrum/example/spec/ui_specs'
    config.acceptable_delta = 0.3 # allow a maximum of 2% difference
  end
end

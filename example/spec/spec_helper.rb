require_relative '../../lib/fever'

RSpec.configure do |config|
  config.include Fever

  Fever.configure do |config|
    config.images_path = '/Users/justin/src/personal/fever/example/spec/ui_specs'
    config.acceptable_delta = 2 # allow a maximum of 2% difference
  end
end

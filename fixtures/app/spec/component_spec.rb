require 'simulacrum_helper'

describe 'UI Component', js: true, sauce: true do
  component :ui_component do |options|
    options.url = '/ui_component.html'
  end
  it { should look_the_same }
end

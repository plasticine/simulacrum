require 'spec_helper'

describe "My Button" do
  component :my_button do |config|
    config.url = 'http://localhost:3000/styleguide/components/button/example'
  end

  it { should look_the_same }
end

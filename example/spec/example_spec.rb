require 'spec_helper'
require 'selenium-webdriver'

describe "My Button" do
  component :my_button do |config|
    config.url = 'http://localhost:3000/banking/styleguide/panels/panel/example'
    config.acceptable_delta = 0.1
  end

  # it { should look_the_same }

  # context "on an iPhone5 running iOS7 in portrait orientation" do
  #   browser :iphone_ios7_portrait do |config|
  #     config = Selenium::WebDriver::Remote::Capabilities.iphone
  #     config.platform = 'OS X 10.9'
  #     config.version = '7'
  #     config['device-orientation'] = 'portrait'
  #   end

  #   it { should look_the_same }
  # end
end

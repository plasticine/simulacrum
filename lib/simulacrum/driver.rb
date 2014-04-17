require 'capybara'

module Simulacrum
  class Driver
    def initialize
      register_driver
      configure_capybara
    end

    private

    def register_driver
      Capybara.register_driver ENV['BS_DRIVER_NAME'] do |app|
        caps = Selenium::WebDriver::Remote::Capabilities.new

        caps['project']            = "UI Regression Testing"
        caps['browserstack.local'] = "true"
        caps['browserstack.debug'] = "false"
        caps['browser']            = ENV['SELENIUM_BROWSER']
        caps['browser_version']    = ENV['SELENIUM_VERSION'] || ""
        caps['os']                 = ENV['BS_AUTOMATE_OS'] || ""
        caps['os_version']         = ENV['BS_AUTOMATE_OS_VERSION'] || ""
        caps['device']             = ENV['BS_AUTOMATE_DEVICE'] || ""
        caps['deviceOrientation']  = ENV['BS_AUTOMATE_DEVICEORIENTATION'] || ""
        caps['platform']           = ENV['BS_AUTOMATE_PLATFORM'] || ""
        caps['resolution']         = ENV['BS_AUTOMATE_RESOLUTION'] || ""
        caps['requireWindowFocus'] = ENV['BS_AUTOMATE_REQUIREWINDOWFOCUS'] || ""

        Capybara::Selenium::Driver.new(app,
          :browser => :remote,
          :url => ENV['SELENIUM_REMOTE_URL'],
          :desired_capabilities => caps
        )
      end
    end

    def configure_capybara
      Capybara.server_host       = 'localhost'
      Capybara.server_port       = ENV['APP_SERVER_PORT'].to_i
      Capybara.default_wait_time = 10
      Capybara.default_driver    = ENV['BS_DRIVER_NAME']
    end
  end
end

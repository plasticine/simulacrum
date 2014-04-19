require 'capybara'

module Simulacrum
  # Responsible for registering a custom Capybara driver for use with Selenium
  # grid endpoints (Browserstack, SauceLabs, etc.). Configures selenium options
  # via ENV vars so that they can be passed into
  class Driver
    def initialize
      register_driver
      configure_capybara
    end

    private

    def register_driver
      Capybara.register_driver driver_name do |app|
        Capybara::Selenium::Driver.new(
          app,
          browser: :remote,
          url: selenium_remote_url,
          desired_capabilities: configure_caps
        )
      end
    end

    def configure_capybara
      Capybara.server_host       = 'localhost'
      Capybara.server_port       = ENV['APP_SERVER_PORT'].to_i
      Capybara.default_wait_time = 10
      Capybara.default_driver    = driver_name
    end

    def configure_caps
      caps = Selenium::WebDriver::Remote::Capabilities.new
      caps['project']            = 'UI Regression Testing'
      caps['browserstack.local'] = 'true'
      caps['browserstack.debug'] = 'false'
      caps['browser']            = browser
      caps['browser_version']    = browser_version
      caps['os']                 = os
      caps['os_version']         = os_version
      caps['device']             = device
      caps['deviceOrientation']  = device_orientation
      caps['platform']           = platform
      caps['resolution']         = resolution
      caps['requireWindowFocus'] = require_window_focus
      caps
    end

    def selenium_remote_url
      ENV['SELENIUM_REMOTE_URL']
    end

    def driver_name
      ENV['BS_DRIVER_NAME']
    end

    def browser
      ENV['SELENIUM_BROWSER']
    end

    def browser_version
      ENV['SELENIUM_VERSION'] || ''
    end

    def os
      ENV['BS_AUTOMATE_OS'] || ''
    end

    def os_version
      ENV['BS_AUTOMATE_OS_VERSION'] || ''
    end

    def device
      ENV['BS_AUTOMATE_DEVICE'] || ''
    end

    def device_orientation
      ENV['BS_AUTOMATE_DEVICEORIENTATION'] || ''
    end

    def platform
      ENV['BS_AUTOMATE_PLATFORM'] || ''
    end

    def resolution
      ENV['BS_AUTOMATE_RESOLUTION'] || ''
    end

    def require_window_focus
      ENV['BS_AUTOMATE_REQUIREWINDOWFOCUS'] || ''
    end
  end
end

# encoding: UTF-8
require 'simulacrum/driver/base'
require 'capybara'
require 'selenium-webdriver'
require 'selenium/webdriver/remote/http/curb'
require 'pry'

module Simulacrum
  module Driver
    # Responsible for registering a custom Capybara driver for use with
    # Selenium grid endpoints (Browserstack, SauceLabs, etc.). Configures
    # selenium options via ENV vars so that they can be passed into
    class BrowserstackDriver < Simulacrum::Driver::Base
      private

      def configuration
        {
          browser: :remote,
          url: selenium_remote_url,
          desired_capabilities: capabilities,
          http_client: http_client
        }
      end

      def http_client
        Selenium::WebDriver::Remote::Http::Curb.new
      end

      def capabilities
        caps = Selenium::WebDriver::Remote::Capabilities.new
        caps['project']            = 'UI Regression Testing'
        caps['browserstack.local'] = true
        caps['browserstack.debug'] = true
        caps['browser']            = browser
        caps['browserName']        = browser_name
        caps['browser_version']    = browser_version
        caps['os']                 = os
        caps['os_version']         = os_version
        caps['device']             = device
        caps['deviceOrientation']  = device_orientation
        caps['platform']           = platform
        caps['resolution']         = resolution
        caps['requireWindowFocus'] = require_window_focus
        caps['realMobile']         = real_mobile
        caps
      end

      def browser
        ENV['SELENIUM_BROWSER']
      end

      def browser_name
        ENV['BS_BROWSERNAME'] || ''
      end

      def real_mobile
        ENV['BS_REALMOBILE'] || false
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
end

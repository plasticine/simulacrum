module Simulacrum
  module Driver
    # Base class for Drivers to inherit
    class Base
      def self.use
        new.use
      end

      def use
        register_driver
        configure_capybara
      end

      private

      def capabilities
      end

      def configuration
      end

      def register_driver
        Capybara.register_driver driver_name do |app|
          Capybara::Selenium::Driver.new(app, configuration)
        end
      end

      def configure_capybara
        Capybara.default_driver    = driver_name
        Capybara.default_wait_time = 10
        Capybara.server_host       = 'localhost'
        Capybara.server_port       = app_server_port
      end

      def app_server_port
        ENV['APP_SERVER_PORT'].to_i if ENV['APP_SERVER_PORT']
      end

      def selenium_remote_url
        ENV['SELENIUM_REMOTE_URL']
      end

      def driver_name
        ENV['BS_DRIVER_NAME']
      end
    end
  end
end

# encoding: UTF-8
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
        self
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
      end
    end
  end
end

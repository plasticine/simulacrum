# encoding: UTF-8
module Simulacrum
  # Base class for Drivers to inherit
  class Driver
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
      { browser: :firefox }
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

    def driver_name
      'local'
    end
  end
end

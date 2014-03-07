require 'capybara'

module Simulacrum
  class Browser
    attr_reader :name, :options

    def initialize(name, options)
      @name = name
      @options = options
    end

    def use
      register_driver
      Capybara.default_driver = name.to_sym
    end

    def configure(config)
      puts config.inspect
    end

    def capture_delay
      @options.capture_delay || Simulacrum.configuration.capture_delay
    end

    def remote?
      @options.remote.nil? ? false : @options.remote
    end

    private

    def driver_options
      options = { desired_capabilities: @options.caps }
      options[:browser] = :remote if remote?
      options[:url] = Simulacrum.configuration.remote_url if remote?
      options
    end

    def register_driver
      Capybara.register_driver name.to_sym do |app|
        Capybara::Selenium::Driver.new(app, driver_options)
      end
    end
  end
end

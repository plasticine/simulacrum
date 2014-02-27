require 'capybara'

module Simulacrum
  class Browser
    attr_reader :name

    def initialize(name, options)
      @name = name
      @options = options
    end

    def use
      Capybara.default_driver = :sauce
    end
  end
end

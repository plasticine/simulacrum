require 'ostruct'
require_relative 'browser'
require_relative 'component'

module Simulacrum
  # Rspec utility methods for defining components, browser environments and
  module Methods
    def component(name, &block)
      options = OpenStruct.new
      yield options
      component = Simulacrum::Component.new(name, options)
      Simulacrum.components[name] = component

      subject do
        component
      end
    end

    def configure_browser(name, &block)
      options = OpenStruct.new
      yield options
      @browser = Simulacrum::Browser.new(name, options)
    end
  end
end

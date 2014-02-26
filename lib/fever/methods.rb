require 'ostruct'
require_relative 'browser'
require_relative 'component'

module Fever
  # Rspec utility methods for defining components, browser environments and
  module Methods
    def component(name, &block)
      options = OpenStruct.new
      yield options
      component = Fever::Component.new(name, options)
      Fever.components[name] = component

      subject do
        component
      end
    end

    def configure_browser(name, &block)
      options = OpenStruct.new
      yield options
      @browser = Fever::Browser.new(name, options)
    end
  end
end

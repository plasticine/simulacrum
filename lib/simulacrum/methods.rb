require 'ostruct'
require_relative './component'

module Simulacrum
  # Rspec utility methods for defining components, browser environments
  module Methods
    def component(name, &block)
      options = OpenStruct.new
      yield options
      component = Simulacrum::Component.new(name, options)
      Simulacrum.components[name] = component

      subject do
        component
      end

      let(:component) do
        component
      end
    end

    def use_window_size(dimensions)
      subject do
        component.set_window_size(dimensions)
      end

      after(:each) do
        subject.reset_window_size
      end
    end
  end
end

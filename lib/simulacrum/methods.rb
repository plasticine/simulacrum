require 'ostruct'
require_relative 'browser'
require_relative 'component'

module Simulacrum
  # Rspec utility methods for defining components, browser environments
  module Methods
    def component(name, &block)
      options = OpenStruct.new
      yield options
      component = Simulacrum::Component.new(name, nil, options)
      Simulacrum.components[name] = component
      subject { component }
      let(:component) { component }
    end

    def browser(name, &block)
      options = OpenStruct.new
      options.caps = {}
      yield options
      Simulacrum.browsers[name] = Simulacrum::Browser.new(name, options)
      let(name.to_sym) { browser }
    end

    def use_browser(name, extra_config = {})
      previous_browser = Simulacrum.current_browser
      current_browser = Simulacrum.browsers[name]
      current_browser.configure(extra_config)
      Simulacrum.current_browser = current_browser
      subject { component.render_with(current_browser) }
      after(:each) {
        Simulacrum.current_browser = previous_browser
        component.render_with(previous_browser)
      }
    end
  end
end

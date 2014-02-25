require 'ostruct'

module Fever
  #
  # Rspec utility methods for defining components, browser environments and
  #
  module Methods
    def self.component(name, &block)
      options = OpenStruct.new
      yield options
      @component = Fever::Component.new(name, options)
    end

    def self.configure_browser(name, &block)
      options = OpenStruct.new
      yield options
      @browser = Fever::Browser.new(name, options)
    end

    def self.it_looks_the_same
      Fever::Comparator.new(@component)
    end
  end
end

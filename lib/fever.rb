require 'ostruct'
require_relative 'fever/methods'
require_relative 'fever/matchers'
require_relative 'fever/configuration'

# Gem module
module Fever
  @components = {}
  @configuration = Fever::Configuration.new

  def self.components
    @components
  end

  def self.configuration
    @configuration
  end

  def self.configure(&block)
    options = OpenStruct.new
    yield options
    @configuration.configure(options.to_h)
  end

  def self.included(receiver, &block)
    receiver.extend         Fever::Methods
    receiver.send :include, Fever::Matchers
  end
end

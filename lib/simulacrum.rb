require 'ostruct'
require_relative 'Simulacrum/methods'
require_relative 'Simulacrum/matchers'
require_relative 'Simulacrum/configuration'

# Gem module
module Simulacrum
  @browsers = {}
  @components = {}
  @configuration = Simulacrum::Configuration.new

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
    receiver.extend         Simulacrum::Methods
    receiver.send :include, Simulacrum::Matchers
  end
end

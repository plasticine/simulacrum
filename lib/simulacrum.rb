require 'ostruct'
require_relative 'Simulacrum/methods'
require_relative 'Simulacrum/matchers'
require_relative 'Simulacrum/configuration'

# Gem module
module Simulacrum
  @current_browser = nil
  @browsers = {}
  @components = {}
  @configuration = Simulacrum::Configuration.new

  Capybara.configure do |config|
    config.default_driver = :selenium
  end

  def self.components
    @components
  end

  def self.browsers
    @browsers
  end

  def self.current_browser
    @current_browser
  end

  def self.current_browser=(browser)
    @current_browser = browser
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

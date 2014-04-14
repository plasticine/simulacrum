require 'ostruct'
require 'capybara'
require_relative './simulacrum/methods'
require_relative './simulacrum/matchers'
require_relative './simulacrum/configuration'
require_relative "./simulacrum/railtie" if defined? Rails::Railtie
require_relative './simulacrum/runners/browserstack/runner'

# Gem module
module Simulacrum
  @browsers = {}
  @components = {}
  @current_browser = nil
  @configuration = Simulacrum::Configuration.new

  def self.components
    @components
  end

  def self.configuration
    @configuration
  end

  def self.configure(&block)
    options = OpenStruct.new(defaults: OpenStruct.new)
    yield options
    @configuration.configure(options.to_h)
  end

  def self.included(receiver, &block)
    receiver.extend         Simulacrum::Methods
    receiver.send :include, Simulacrum::Matchers

    if defined?(Rails)
      receiver.send :include, Rails.application.routes.url_helpers
      receiver.send :include, Rails.application.routes.mounted_helpers
    end
  end
end

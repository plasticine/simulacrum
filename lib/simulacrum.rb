# encoding: UTF-8
require 'ostruct'
require_relative './simulacrum/methods'
require_relative './simulacrum/matchers'
require_relative './simulacrum/configuration'
require_relative './simulacrum/railtie' if defined? Rails::Railtie
require_relative './simulacrum/runners/browserstack/runner'
require_relative './simulacrum/driver'

# Gem module
module Simulacrum
  mattr_accessor :components, :configuration

  @driver = nil
  @components = {}
  @current_browser = nil
  @configuration = Simulacrum::Configuration.new

  def self.root
    File.expand_path('../..', __FILE__)
  end

  def self.configure(&block)
    options = OpenStruct.new(defaults: OpenStruct.new)
    yield options
    @configuration.configure(options.to_h)
  end

  def self.included(receiver, &block)
    @driver = Simulacrum::Driver.new

    receiver.extend Simulacrum::Methods
    receiver.send :include, Simulacrum::Matchers

    if defined?(Rails)
      receiver.send :include, Rails.application.routes.url_helpers
      receiver.send :include, Rails.application.routes.mounted_helpers
    end
  end
end

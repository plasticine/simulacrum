# encoding: UTF-8
require 'ostruct'
require_relative './simulacrum/methods'
require_relative './simulacrum/matchers'
require_relative './simulacrum/configuration'
require_relative './simulacrum/railtie' if defined? Rails::Railtie
require_relative './simulacrum/runner'
require_relative './simulacrum/driver'

# Gem module
module Simulacrum
  @driver = nil
  @components = {}
  @current_browser = nil
  @configuration = Simulacrum::Configuration.new

  def components
    @components
  end
  module_function :components

  def configuration
    @configuration
  end
  module_function :configuration

  def driver
    @driver ||= Simulacrum::Driver.new
  end
  module_function :driver

  def root
    File.expand_path('../..', __FILE__)
  end
  module_function :root

  def run(options)
    Simulacrum::Runner.run(options)
  end
  module_function :run

  def configure(&block)
    options = OpenStruct.new(defaults: OpenStruct.new)
    yield options
    configuration.configure(options.to_h)
  end
  module_function :configure

  def included(receiver, &block)
    receiver.extend Simulacrum::Methods
    receiver.send :include, Simulacrum::Matchers

    if defined?(Rails)
      receiver.send :include, Rails.application.routes.url_helpers
      receiver.send :include, Rails.application.routes.mounted_helpers
    end
  end
  module_function :included
end

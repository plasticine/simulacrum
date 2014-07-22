# encoding: UTF-8
require 'ostruct'
require 'capybara'
require_relative './simulacrum/methods'
require_relative './simulacrum/matchers'
require_relative './simulacrum/configuration'
require_relative './simulacrum/railtie' if defined? Rails::Railtie
require_relative './simulacrum/runner'

# Gem module
module Simulacrum
  CONFIG_FILE = './.simulacrum.yml'

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

  def runner_options
    @runner_options
  end
  module_function :runner_options

  def root
    File.expand_path('../..', __FILE__)
  end
  module_function :root

  def run(options)
    @runner_options = options
    Simulacrum::Runner.run
  end
  module_function :run

  def configure(&block)
    options = OpenStruct.new(component: OpenStruct.new)
    yield options
    configuration.configure(options.to_h)
  end
  module_function :configure

  def config_file
    YAML.load_file(Simulacrum.config_file_path)
  end
  module_function :config_file

  def config_file?
    File.exist?(Simulacrum.config_file_path)
  end
  module_function :config_file?

  def config_file_path
    if defined? Rails
      Rails.root.join(CONFIG_FILE)
    else
      CONFIG_FILE
    end
  end
  module_function :config_file_path
end

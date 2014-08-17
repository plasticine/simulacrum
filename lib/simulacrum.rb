# encoding: UTF-8
require 'yaml'
require 'ostruct'
require 'capybara'
require 'logger'
require 'simulacrum/configuration'
require 'simulacrum/runner'

# Gem module
module Simulacrum
  CONFIG_FILE = './.simulacrum.yml'

  @components = {}
  @current_browser = nil
  @configuration = Simulacrum::Configuration.new
  @logger = Logger.new($stdout)

  def logger
    @logger
  end
  module_function :logger

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
    configure_logger
    configure_runner.run
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

  def self.configure_runner
    Simulacrum::Runner
  end

  def self.configure_logger
    @logger.level = @runner_options.verbose ? Logger::DEBUG : Logger::INFO
  end
end

# encoding: UTF-8
require 'rspec'
require 'simulacrum/driver'
require 'simulacrum/methods'
require 'simulacrum/matchers'

module Simulacrum
  # Base Runner class for running RSpec in parallel.
  class Runner
    attr_reader :exit_code

    def initialize
      configure_driver
      configure_rspec
    end

    def run
      puts 'Simulacrum::Runner.run'
      @exit_code = run_rspec
    end

    private

    def configure_driver
      puts 'Simulacrum::Runner.configure_driver'
      Simulacrum::Driver.use
    end

    def run_rspec
      puts 'Simulacrum::Runner.run_rspec'
      RSpec::Core::Runner.run(test_files)
    end

    def test_files
      Simulacrum.runner_options.files
    end

    def configure_rspec
      puts 'Simulacrum::Runner.configure_rspec'
      RSpec.configuration.include Simulacrum::Matchers
      RSpec.configuration.extend Simulacrum::Methods
      RSpec.configuration.color = Simulacrum.runner_options.color
      RSpec.configuration.tty = true
      RSpec.configuration.pattern = '**/*_spec.rb'
      RSpec.configuration.profile_examples = false
    end
  end
end

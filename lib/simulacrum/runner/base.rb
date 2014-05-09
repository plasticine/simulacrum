# encoding: UTF-8
require 'rspec'
require 'simulacrum/formatters/simulacrum_formatter'
require 'simulacrum/driver/local'

module Simulacrum
  module Runner
    # Base Runner class for running RSpec in parallel.
    class Base
      def initialize
        run
      end

      def run
        configure_driver
        configure_rspec
        run_rspec
      end

      private

      def configure_driver
        Simulacrum::Driver::LocalDriver.use
      end

      def run_rspec
        RSpec::Core::Runner.run(Simulacrum.runner_options.files)
      end

      def configure_rspec
        RSpec.configuration.color = Simulacrum.runner_options.color
        RSpec.configuration.color_enabled = Simulacrum.runner_options.color
        RSpec.configuration.tty = true
        RSpec.configuration.pattern = '**/*_spec.rb'
        RSpec.configuration.profile_examples = false
        RSpec.configuration.instance_variable_set(:@requires, required_helpers)
      end

      def required_helpers
        ['spec/simulacrum_helper']
      end
    end
  end
end

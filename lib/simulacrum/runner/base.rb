# encoding: UTF-8
require 'rspec'
require 'simulacrum'
require 'simulacrum/formatters/simulacrum_formatter'
require 'simulacrum/driver/local'

module Simulacrum
  module Runner
    # Base Runner class for running RSpec in parallel.
    class Base
      attr_reader :exit_code

      def initialize
        run
      end

      def run
        configure_driver
        configure_rspec
        @exit_code = run_rspec
      end

      private

      def configure_driver
        Simulacrum::Driver::LocalDriver.use
      end

      def run_rspec
        RSpec::Core::Runner.run(test_files)
      end

      def test_files
        Simulacrum.runner_options.files
      end

      def configure_rspec
        RSpec.configuration.include Simulacrum::Matchers
        RSpec.configuration.extend Simulacrum::Methods
        RSpec.configuration.color = Simulacrum.runner_options.color
        RSpec.configuration.tty = true
        RSpec.configuration.pattern = '**/*_spec.rb'
        RSpec.configuration.profile_examples = false
      end
    end
  end
end

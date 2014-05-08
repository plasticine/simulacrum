# encoding: UTF-8
require 'rspec'
require 'simulacrum/formatters/simulacrum_formatter'

module Simulacrum
  module Runner
    # Base Runner class for running RSpec in parallel.
    class Base
      def run_suite
        configure_rspec
        invoke_rspec
        { results: dump_results }
      end

      private

      def reporter
        @reporter ||= RSpec::Core::Reporter.new(formatter)
      end

      def formatter
        @formatter ||= Simulacrum::Formatters::SimulacrumFormatter.new($stdout)
      end

      def dump_results
        Marshal.dump(formatter.output_hash)
      end

      def invoke_rspec
        RSpec::Core::Runner.run(['spec/ui'])
      end

      def configure_rspec
        RSpec.configuration.color = true
        RSpec.configuration.color_enabled = true
        RSpec.configuration.tty = true
        RSpec.configuration.pattern = '**/*_spec.rb'
        RSpec.configuration.profile_examples = false
        RSpec.configuration.instance_variable_set(:@requires, required_helpers)
        RSpec.configuration.instance_variable_set(:@reporter, reporter)
      end

      def required_helpers
        ['spec/simulacrum_helper']
      end
    end
  end
end

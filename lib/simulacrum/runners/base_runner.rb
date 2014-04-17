require 'rspec'
require 'simulacrum/formatters/simulacrum_formatter'

module Simulacrum
  module Runners
    class BaseRunner
      def run
        formatter = Simulacrum::Formatters::SimulacrumFormatter.new($stdout)
        reporter = RSpec::Core::Reporter.new(formatter)
        configure_rspec(reporter)
        invoke_rspec
        {results: Marshal.dump(formatter.output_hash)}
      end

      private

      def invoke_rspec
        RSpec::Core::Runner.run(['spec/ui'])
      end

      def configure_rspec(reporter)
        RSpec.configuration.color = true
        RSpec.configuration.color_enabled = true
        RSpec.configuration.tty = true
        RSpec.configuration.pattern = "**/*_spec.rb"
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

# encoding: UTF-8
require 'rspec/core/formatters/json_formatter'
require 'rspec/core/formatters/base_text_formatter'

module Simulacrum
  module Formatters
    # Class responsible for printing output from the RSpec run, and logging
    # detail into structs that are dumped out to be reconstituted and consumed
    # or aggregated later.
    class SimulacrumFormatter < RSpec::Core::Formatters::BaseTextFormatter
      # TODO: Rename this - StructFormatter?

      attr_reader :output_hash

      SummaryStruct = Struct.new(:duration, :example_count, :failure_count,
                                 :pending_count)
      ExampleStruct = Struct.new(:description, :full_description,
                                 :execution_result, :metadata, :exception,
                                 :location, :file_path)

      def initialize(output)
        super
        @output_hash = {}
      end

      def example_passed(notification)
        output.print success_color('.')
      end

      def example_pending(notification)
        super
        output.print pending_color('*')
      end

      def example_failed(notification)
        super
        output.print failure_color('F')
      end

      def dump_failures; end

      def dump_pending; end

      def dump_profile; end

      def dump_summary(duration, example_count, failure_count, pending_count)
        @output_hash[:summary] = SummaryStruct.new(
          duration,
          example_count,
          failure_count,
          pending_count
        )
      end

      def stop
        super
        @output_hash[:examples] = examples.map do |example|
          struct_for_example(example)
        end
      end

      private

      def struct_for_example(example)
        ExampleStruct.new(
          example.description,
          example.full_description,
          example.execution_result,
          { execution_result: example.metadata[:execution_result] },
          example.exception,
          example.location,
          example.file_path
        )
      end
    end
  end
end

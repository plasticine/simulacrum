require 'rspec/core/formatters/json_formatter'
require 'rspec/core/formatters/base_text_formatter'

module Simulacrum
  module Formatters
    class SimulacrumFormatter < RSpec::Core::Formatters::BaseTextFormatter
      attr_reader :output_hash

      def initialize(output)
        super
        @output_hash = {}
      end

      def message(message)
        (@output_hash[:messages] ||= []) << message
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

      def dump_profile; end

      def dump_summary(duration, example_count, failure_count, pending_count)
        @output_hash[:summary] = {
          :duration => duration,
          :example_count => example_count,
          :failure_count => failure_count,
          :pending_count => pending_count
        }
        @output_hash[:summary_line] = summary_line(example_count, failure_count, pending_count)
      end

      def summary_line(example_count, failure_count, pending_count)
        summary = pluralize(example_count, "example")
        summary << ", " << pluralize(failure_count, "failure")
        summary << ", #{pending_count} pending" if pending_count > 0
        summary
      end

      def stop
        super
        @output_hash[:examples] = examples.map do |example|
          {
            :description => example.description,
            :full_description => example.full_description,
            :status => example.execution_result[:status],
            :file_path => example.metadata[:file_path],
            :line_number  => example.metadata[:line_number],
          }.tap do |hash|
            if e=example.exception
              hash[:exception] =  {
                :class => e.class.name,
                :message => e.message,
                :backtrace => e.backtrace,
              }
            end
          end
        end
      end
    end
  end
end

# encoding: UTF-8
require 'rspec/core/formatters/helpers'
require 'rspec/core/formatters/base_text_formatter'

module Simulacrum
  module Browserstack
    # The Summary Class is responsible for combining dumped examlpes from one
    # or more other RSpec runs.
    class Summary < RSpec::Core::Formatters::BaseTextFormatter
      # TODO: Rename me, I'm really just a formatter anyway
      # TODO: Also, should this just be an external gem...? Prolly not?
      def initialize(results_set, start_time, end_time)
        super($stdout)
        @results_set = results_set
        @start_time = start_time
        @end_time = end_time
      end

      def dump_commands_to_rerun_failed_examples
        return if failed_examples.empty?
        output.puts
        output.puts('Failed examples:')
        output.puts

        failed_examples.each do |example|
          output.puts(failure_color("simulacrum --browser=#{example.metadata[:browser]} #{RSpec::Core::Metadata::relative_path(example.location)}") + ' ' + detail_color("# #{example.full_description}"))
        end
      end

      def dump_summary
        super(duration, example_count, failure_count, pending_count)
      end

      def failed_examples
        examples.select do |example|
          example.execution_result[:status] == 'failed'
        end
      end

      def pending_examples
        examples.select do |example|
          example.execution_result[:status] == 'pending'
        end
      end

      def duration
        @end_time - @start_time
      end

      def example_count
        summaries.map { |x| x[:example_count] }.reduce(:+)
      end

      def failure_count
        summaries.map { |x| x[:failure_count] }.reduce(:+)
      end

      def pending_count
        summaries.map { |x| x[:pending_count] }.reduce(:+)
      end

      def find_shared_group(example)
      end

      def group_and_parent_groups(example)
      end

      private

      def color_enabled?
        Simulacrum.runner_options.color
      end

      def examples
        dumped_results.map { |result| result[:examples] }.flatten
      end

      def summaries
        dumped_results.map { |result| result[:summary] }.flatten
      end

      def dumped_results
        @dumped_results ||= @results_set.map do |result|
          Marshal.load(result[:results])
        end
      end
    end
  end
end

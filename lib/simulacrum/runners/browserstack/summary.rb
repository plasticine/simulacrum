require 'rspec/core/formatters/helpers'
require 'rspec/core/formatters/base_text_formatter'

module Simulacrum
  module Browserstack
    class Summary < RSpec::Core::Formatters::BaseTextFormatter
      include RSpec::Core::Formatters::Helpers

      def initialize(results_set)
        super($stdout)
        @results_set = results_set
      end

      def dump_summary
        super(duration, example_count, failure_count, pending_count)
      end

      def failed_examples
        examples.select {|example| example.execution_result[:status] == 'failed' }
      end

      def pending_examples
        examples.select {|example| example.execution_result[:status] == 'pending' }
      end

      def duration
        summaries.map{|x| x[:duration] }.reduce(:+)
      end

      def example_count
        summaries.map{|x| x[:example_count] }.reduce(:+)
      end

      def failure_count
        summaries.map{|x| x[:failure_count] }.reduce(:+)
      end

      def pending_count
        summaries.map{|x| x[:pending_count] }.reduce(:+)
      end

      def find_shared_group(example); end
      def group_and_parent_groups(example); end

    private

      def color_enabled?
        true
      end

      def examples
        dumped_results.map {|result| result[:examples] }.flatten
      end

      def summaries
        dumped_results.map {|result| result[:summary] }.flatten
      end

      def dumped_results
        @dumped_results ||= @results_set.map {|result| Marshal.load(result[:results]) }
      end
    end
  end
end

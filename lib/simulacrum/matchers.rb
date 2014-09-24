# encoding: UTF-8
require 'rspec'
require_relative './comparator'

module Simulacrum
  # Custom RSpec matchers
  module Matchers
    extend RSpec::Matchers::DSL

    matcher :look_the_same do
      match do |component|
        component = component
        comparator = Simulacrum::Comparator.new(component)

        case comparator.test
        when true
          true
        when false
          fail Simulacrum::Matchers.fail_message(component, comparator)
        when nil
          skip Simulacrum::Matchers.pending_message(component)
        end
      end
    end

    def self.fail_message(component, comparator)
      <<-eos
The pixel change percentage (#{comparator.diff.delta}%) exceeded the maximum \
threshold of #{component.delta_threshold}%.

Reference: #{component.reference_path}
Candidate: #{component.candidate_path}
Diff:      #{component.diff_path}
      eos
    end

    def self.pending_message(component)
      <<-eos
No reference image found! Candidate created: #{component.candidate_path}
      eos
    end
  end
end

# encoding: UTF-8
require 'rspec'
require_relative './diff/rmagick'

module Simulacrum
  # The Comparator class is responsible for comparing and handling
  # processing of screenshots and candidates
  class Comparator
    include RSpec::Core::Pending

    attr_accessor :component, :candidate, :diff

    def initialize(component)
      @component = component
      @component.render
    end

    def test
      # If the component has a reference then we should diff the candidate
      # image against the reference
      if component.reference?
        # If there is a diff between the candidate and the reference then we
        # should save both the candidate and diff images and fail the test
        perform_diff ? pass : fail

      # Otherwise we should just write the captured candidate to disk, and mark
      # the spec as being pending until the user works out if the candidate is
      # OK by renaming candidate.png to reference.png
      else
        skip
      end
    end

    private

    def pass
      component.remove_candidate
      component.remove_diff
      true
    end

    def fail
      @diff.save(component.diff_path)
      false
    end

    def skip
      nil
    end

    def perform_diff
      # TODO: Support dynamic diffing strategies?
      @diff = Simulacrum::RMagicDiff.new(
        component.reference_path,
        component.candidate_path
      )
      diff_delta_percent_is_acceptable
    end

    def diff_delta_percent_is_acceptable
      diff.delta < component.delta_threshold
    end
  end
end

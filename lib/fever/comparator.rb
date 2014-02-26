require_relative 'diff/rmagick'

module Fever
  # The Comparator class is responsible for comparing and handling
  # processing of screenshots and candidates
  class Comparator
    include RSpec::Core::Pending

    attr_accessor :component, :candidate, :diff

    def initialize(component)
      @component = component
    end

    def test
      @candidate = @component.capture_candidate

      # If the component has a reference then we should diff the candidate
      # image against the reference
      if @component.reference?
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
      @component.remove_candidate
      true
    end

    def fail
      @diff.save(@component.diff_path)
      false
    end

    def skip
      nil
    end

    def perform_diff()
      @diff = Fever::RmagicDiff.new(@component.reference_path,
                                    @component.candidate_path)
      diff_delta_percent_is_acceptable
    end

    def diff_delta_percent_is_acceptable
      (@diff.delta * 1000) < @component.acceptable_delta
    end
  end
end

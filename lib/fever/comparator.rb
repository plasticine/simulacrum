require 'rmagick'

module Fever
  # The Comparator class is responsible for comparing and handling
  # processing of screenshots and candidates
  class Comparator
    def initialize(component)
      @candidate = @component.capture

      # If the component has a reference then we should diff the candidate image
      # against the reference
      if @component.reference?
        @diff = diff(candidate)

        # If there is a diff between the candidate and the reference then we
        # should save both the candidate and diff images and fail the test
        @diff.nil? ? pass : fail

      # Otherwise we should just write the captured candidate to disk, and mark
      # the spec as being pending until the user works out if the candidate is OK
      else
        skipped
      end
    end

    private

    def pass
      true
    end

    def fail
      @diff.save
      @candidate.save
      fail 'Images are not the same! Please resolve the diff!'
    end

    def skipped
      @candidate.save
      pending("#{@component.candidate_path} written to disk — please resolve")
    end

    def diff(candidate)
      reference_image = Magick::Image.read(@component.reference_path)
      candidate_image = Magick::Image.read(candidate) # read in image data from string? or temp file?
      diff_image, diff_metric = compare_images(reference_image, candidate_image)

      return diff_image if diff_error?(diff_metric)
    end

    def diff_error?(diff_metric)
      diff_metric != 0.0
    end

    def compare_images(reference_image, candidate_image)
      reference_image[0].compare_channel(
        candidate_image[0],
        Magick::MeanSquaredErrorMetric
      )
    end
  end
end

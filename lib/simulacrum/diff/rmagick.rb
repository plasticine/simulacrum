require 'rmagick'
require_relative '../diff'

module Simulacrum
  class RmagicDiff < Simulacrum::Diff
    private

    def compare
      a_image = Magick::Image.read(@a_path)
      b_image = Magick::Image.read(@b_path)
      @image, @delta = compare_images(a_image, b_image)
    end

    def compare_images(a_image, b_image)
      a_image[0].compare_channel(b_image[0], Magick::MeanSquaredErrorMetric)
    end
  end
end

require 'RMagick'
require_relative '../diff'

module Simulacrum
  class RmagicDiff < Simulacrum::Diff
    def delta_percent
      @delta * 100
    end

    private

    def compare
      a = Magick::Image.read(@a_path)
      b = Magick::Image.read(@b_path)
      @image, @delta = compare_images(a, b)
    end

    def compare_images(a, b)
      # Calculate the Square Root Mean Squared Error for the comparison of the
      # two images.
      #
      # Gets the color difference for each pixel, and square it, average all the
      # squared differences, then return the square root.
      #
      # http://www.imagemagick.org/discourse-server/viewtopic.php?f=1&t=17284
      a[0].compare_channel(b[0], Magick::MeanSquaredErrorMetric)
    end
  end
end

require 'chunky_png'
require_relative '../diff'

module Fever
  class Pdiff < Fever::Diff
    include ChunkyPNG::Color

    def compare
      a_image = ChunkyPNG::Image.from_file(@a_path)
      b_image = ChunkyPNG::Image.from_file(@b_path)
    end
  end
end

# require 'chunky_png'
# include ChunkyPNG::Color


# images = [
#   ChunkyPNG::Image.from_file('1.png'),
#   ChunkyPNG::Image.from_file('2.png')
# ]

# output = ChunkyPNG::Image.new(images.first.width, images.last.width, WHITE)

# diff = []

# images.first.height.times do |y|
#   images.first.row(y).each_with_index do |pixel, x|
#     unless pixel == images.last[x,y]
#       score = Math.sqrt(
#         (r(images.last[x,y]) - r(pixel)) ** 2 +
#         (g(images.last[x,y]) - g(pixel)) ** 2 +
#         (b(images.last[x,y]) - b(pixel)) ** 2
#       ) / Math.sqrt(MAX ** 2 * 3)

#       output[x,y] = grayscale(MAX - (score * MAX).round)
#       diff << score
#     end
#   end
# end

# puts "pixels (total):     #{images.first.pixels.length}"
# puts "pixels changed:     #{diff.length}"
# puts "image changed (%): #{(diff.inject {|sum, value| sum + value} / images.first.pixels.length) * 100}%"

# output.save('diff.png')

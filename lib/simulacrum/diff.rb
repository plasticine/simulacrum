# encoding: UTF-8
module Simulacrum
  # Base class for implementing diffing strategies
  class Diff
    attr_accessor :a_path, :b_path, :delta, :image

    def initialize(a_path, b_path)
      @a_path = a_path
      @b_path = b_path

      compare
    end

    def save(path)
      @image.write(path)
    end
  end
end

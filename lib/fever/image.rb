module Fever
  class Image

    def initialize(file_name)
      @file_name = file_name
    end

    def path
      @path ||= derp
    end

    def exists?
      File.exists?(path)
    end
  end
end

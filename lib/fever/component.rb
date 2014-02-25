module Fever
  class Component
    attr_reader :name

    def initialize(name, configuration)
      @name = name
      @configuration = configuration
    end

    def root_path
      File.join('components', name.to_s)
    end

    def reference_path
      File.join(root_path, 'reference.png')
    end

    def candidate_path
      File.join(root_path, 'candidate.png')
    end

    def diff_path
      File.join(root_path, 'diff.png')
    end

    def reference?
      File.exists?(File.join(path, 'reference.png'))
    end

    def capture

    end
  end
end

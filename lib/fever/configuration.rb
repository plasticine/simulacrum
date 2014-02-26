require 'ostruct'

module Simulacrum
  class Configuration
    attr_reader :images_path, :reference_filename, :candidate_filename,
      :diff_filename, :capture_selector, :acceptable_delta

    def initialize
      @config = OpenStruct.new
    end

    def configure(config)
      @config = OpenStruct.new(@config.to_h.merge!(config))
    end

    def images_path
      @config.images_path
    end

    def reference_filename
      @config.reference_filename || 'reference.png'
    end

    def candidate_filename
      @config.candidate_filename || 'candidate.png'
    end

    def diff_filename
      @config.diff_filename || 'diff.png'
    end

    def capture_selector
      @config.capture_selector || 'html'
    end

    def acceptable_delta
      @config.acceptable_delta || 0.0
    end
  end
end

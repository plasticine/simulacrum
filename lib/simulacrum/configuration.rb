require 'ostruct'

module Simulacrum
  class Configuration
    attr_reader :images_path, :reference_filename, :candidate_filename,
      :diff_filename, :capture_selector, :acceptable_delta, :capture_delay

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

    def capture_delay
      @config.capture_delay || 0
    end

    def acceptable_delta
      @config.acceptable_delta || 0.0
    end

    def remote_url
      @config.remote_url
    end
  end
end

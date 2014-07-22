# encoding: UTF-8
require 'ostruct'

module Simulacrum
  # Configuration Class for managing config of the suite
  class Configuration
    COMPONENT_DEFAULTS = {
      delta_threshold:  1,
      window_size:      [1024, 768],
      capture_delay:    nil,
      capture_selector: :html
    }

    attr_reader :references_path, :reference_filename, :candidate_filename,
                :diff_filename, :delta_threshold, :capture_delay,
                :window_size, :capture_selector, :default_browser

    def initialize
      @config = OpenStruct.new(component: OpenStruct.new(COMPONENT_DEFAULTS))
    end

    def configure(config = {})
      @config = OpenStruct.new(@config.to_h.merge!(config))
    end

    def references_path
      if @config.references_path
        @config.references_path
      elsif defined?(Rails)
        File.join(Rails.root, 'spec/ui/references')
      else
        'spec/ui/references'
      end
    end

    def reference_filename
      @config.reference_filename || 'reference'
    end

    def candidate_filename
      @config.candidate_filename || 'candidate'
    end

    def diff_filename
      @config.diff_filename || 'diff'
    end

    def delta_threshold
      @config.component.delta_threshold || 0.0
    end

    def capture_selector
      @config.component.capture_selector || nil
    end
  end
end

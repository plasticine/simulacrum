require 'ostruct'

module Simulacrum
  class Configuration

    COMPONENT_DEFAULTS = {
      acceptable_delta: 1,
      window_size:      [1024, 768],
      capture_delay:    nil,
      capture_selector: :html,
    }

    attr_reader :references_path, :reference_filename, :candidate_filename,
      :diff_filename, :acceptable_delta, :capture_delay, :window_size,
      :capture_selector, :default_browser

    def initialize
      @config = OpenStruct.new(defaults: OpenStruct.new(COMPONENT_DEFAULTS))
    end

    def configure(config)
      @config = OpenStruct.new(@config.to_h.merge!(config))
    end

    def default_browser
      @config.default_browser || :selenium
    end

    def references_path
      if @config.references_path
        @config.references_path
      elsif defined?(Rails)
        File.join(Rails.root, 'spec/ui/references')
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

    def acceptable_delta
      @config.defaults.acceptable_delta || 0.0
    end

    def capture_selector
      @config.defaults.capture_selector || nil
    end
  end
end

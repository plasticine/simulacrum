require 'capybara'

module Simulacrum
  class Component
    include Capybara::DSL
    Capybara.default_driver = :selenium

    attr_reader :name

    def initialize(name, options)
      @name = name
      @options = options
    end

    # Load up the component url and capture an image, returns a File object
    def capture_candidate
      ensure_example_path
      visit(@options.url)
      within(capture_selector) do
        page.save_screenshot(candidate_path)
      end
    end

    def remove_candidate
      FileUtils.rm(candidate_path) if candidate?
    end

    def remove_diff
      FileUtils.rm(diff_path) if diff?
    end

    def root_path
      File.join(Simulacrum.configuration.images_path, name.to_s)
    end

    def reference_path
      File.join(root_path, Simulacrum.configuration.reference_filename)
    end

    def candidate_path
      File.join(root_path, Simulacrum.configuration.candidate_filename)
    end

    def diff_path
      File.join(root_path, Simulacrum.configuration.diff_filename)
    end

    def reference?
      File.exists?(reference_path)
    end

    def candidate?
      File.exists?(candidate_path)
    end

    def diff?
      File.exists?(diff_path)
    end

    def acceptable_delta
      @options.acceptable_delta || Simulacrum.configuration.acceptable_delta
    end

    private

    def ensure_example_path
      FileUtils.mkdir_p(root_path)
    end

    def capture_selector
      @options.capture_selector || Simulacrum.configuration.capture_selector
    end
  end
end

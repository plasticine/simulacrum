require 'capybara/dsl'

module Simulacrum
  class Component
    include Capybara::DSL

    attr_reader :name, :browser
    attr_accessor :options

    def initialize(name, browser = nil, options = {})
      @name = name
      @options = options
      @browser = browser
    end

    # Load up the component url and capture an image, returns a File object
    def render
      use_browser
      ensure_example_path
      visit(@options.url)
      page.driver.save_screenshot(candidate_path, options)
      kill_driver
    end

    def render_with(browser)
      self.class.new(name, browser, @options)
    end

    def remove_candidate
      FileUtils.rm(candidate_path) if candidate?
    end

    def remove_diff
      FileUtils.rm(diff_path) if diff?
    end

    def root_path
      File.join(Simulacrum.configuration.images_path, render_path)
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

    def kill_driver
      if not @browser.nil? and @browser.remote?
        page.driver.quit
      end
    end

    def render_path
      path = [name.to_s]
      path << @browser.name unless @browser.nil?
      File.join(path.map(&:to_s))
    end

    def use_browser
      unless @browser.nil?
        @browser.use
        sleep @browser.capture_delay.to_i
      end
    end

    def ensure_example_path
      FileUtils.mkdir_p(root_path)
    end

    def capture_selector
      @options.capture_selector || Simulacrum.configuration.capture_selector
    end
  end
end

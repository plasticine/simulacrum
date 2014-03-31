require 'capybara/dsl'
require 'fileutils'
require 'RMagick'
require_relative 'renderer'

module Simulacrum
  class Component
    attr_reader :name, :browser
    attr_accessor :options

    def initialize(name, options = {})
      @name = name
      @options = options
      @renderer = Simulacrum::Renderer.new(options.url)
    end

    # Load up the component url and capture an image, returns a File object
    def render
      ensure_example_path
      save_candidate(@renderer.render)
      crop_candidate_to_selector
    ensure
      cleanup
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
      options.acceptable_delta || Simulacrum.configuration.acceptable_delta
    end

    def reference_path
      filename = Simulacrum.configuration.reference_filename
      File.join(root_path, "#{filename}.png")
    end

    def candidate_path
      filename = Simulacrum.configuration.candidate_filename
      File.join(root_path, "#{filename}.png")
    end

    def diff_path
      filename = Simulacrum.configuration.diff_filename
      File.join(root_path, "#{filename}.png")
    end

    def remove_candidate
      FileUtils.rm(candidate_path) if candidate?
    end

    def remove_diff
      FileUtils.rm(diff_path) if diff?
    end

    private

    def cleanup
      @renderer.cleanup
      # FileUtils.remove_entry(root_path) unless reference? || candidate? || diff?
    end

    def save_candidate(tmp_image_path)
      FileUtils.mv(tmp_image_path, candidate_path)
    end

    def crop_candidate_to_selector
      unless capture_selector.nil?
        candidate_image = Magick::Image::read(candidate_path).first
        bounds = @renderer.get_bounds_for_selector(capture_selector)
        candidate_image.crop!(*bounds)
        candidate_image.write(candidate_path)
      end
    end

    def root_path
      File.join(Simulacrum.configuration.references_path, name.to_s, driver_path)
    end

    def driver_path
      Capybara.current_driver == :default ? '' : Capybara.current_driver.to_s
    end

    def ensure_example_path
      FileUtils.mkdir_p(root_path)
    end

    def capture_selector
      options.capture_selector || Simulacrum.configuration.capture_selector
    end
  end
end

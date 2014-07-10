# encoding: UTF-8
require 'capybara/dsl'
require 'fileutils'
require 'RMagick'
require_relative 'renderer'

module Simulacrum
  # Component Class is responsible for managing the testing of a component
  # defined in a test suite
  class Component
    attr_accessor :options
    attr_reader :name

    def initialize(name, options = {})
      @name = name
      @options = options
      @renderer = Simulacrum::Renderer.new(options.url)
    end

    def render
      ensure_example_path
      tmp_path = @renderer.render
      save_candidate(tmp_path)
      crop_candidate_to_selector
      true
    ensure
      cleanup
    end

    def reference?
      File.exist?(reference_path)
    end

    def candidate?
      File.exist?(candidate_path)
    end

    def diff?
      File.exist?(diff_path)
    end

    def delta_threshold
      # TODO: These should probably be `configuration.defaults....`
      options.delta_threshold || Simulacrum.configuration.delta_threshold
    end

    def reference_path
      # TODO: These should probably be `configuration.defaults....`
      filename = Simulacrum.configuration.reference_filename
      File.join(root_path, "#{filename}.png")
    end

    def candidate_path
      # TODO: These should probably be `configuration.defaults....`
      filename = Simulacrum.configuration.candidate_filename
      File.join(root_path, "#{filename}.png")
    end

    def diff_path
      # TODO: These should probably be `configuration.defaults....`
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
    end

    def save_candidate(tmp_image_path)
      FileUtils.mv(tmp_image_path, candidate_path)
    end

    def crop_candidate_to_selector
      unless capture_selector
        candidate_image = Magick::Image.read(candidate_path).first
        bounds = @renderer.get_bounds_for_selector(capture_selector)
        candidate_image.crop!(*bounds)
        candidate_image.write(candidate_path)
      end
    end

    def root_path
      File.join(
        Simulacrum.configuration.references_path,
        name.to_s,
        driver_path
      )
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

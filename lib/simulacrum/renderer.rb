# encoding: UTF-8
require 'capybara'
require 'tmpdir'

module Simulacrum
  # The Renderer Class is responsible for driving Capybara and setting up
  # the desired page, screenshotting, croping, etc.
  class Renderer
    include Capybara::DSL

    attr_reader :url, :tmp_path

    def initialize(url)
      @url = url
      @tmp_dir = Dir.mktmpdir
    end

    def render
      page.visit(url)
      resize_window!
      save_screenshot!
    end

    def cleanup
      FileUtils.remove_entry(@tmp_dir)
    end

    def get_bounds_for_selector(selector)
      element = page.find(selector)
      location = element.native.location
      size = element.native.size
      [location.x, location.y, size.width, size.height]
    end

    private

    def resize_window!
      case Capybara.default_driver
      when :poltergeist
        page.driver.resize(*window_size)
      else
        page.driver.browser.manage.window.resize_to(*window_size)
      end
    rescue Selenium::WebDriver::Error::UnknownError
      return
    end

    def save_screenshot!
      case Capybara.default_driver
      when :poltergeist
        page.save_screenshot("#{tmp_path}.png", full: true)
      else
        page.driver.save_screenshot(tmp_path)
      end
    end

    def window_size
      [1024, 768]
    end

    def tmp_path
      @tmp_path ||= File.join(@tmp_dir,
                              Simulacrum.configuration.candidate_filename)
    end
  end
end

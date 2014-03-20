require 'capybara'
require 'tmpdir'

module Simulacrum
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
      begin
        page.driver.browser.manage.window.resize_to(1024, 768)
      rescue Selenium::WebDriver::Error::UnknownError => e
      end
    end

    def save_screenshot!
      page.driver.save_screenshot(tmp_path)
    end

    def tmp_path
      @tmp_path ||= File.join(@tmp_dir, Simulacrum.configuration.candidate_filename)
    end
  end
end

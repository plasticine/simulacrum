# encoding: UTF-8
require_relative './tunnel'
require_relative './summary'
require_relative '../base_runner'
require 'yaml'
require 'parallel'

module Simulacrum
  module Runners
    # A Runner Class for Browserstack that handles creating a Browserstack
    # tunnel, closing it when done. Also handles running the suite in parallel.
    class BrowserstackRunner < Simulacrum::Runners::BaseRunner
      attr_accessor :processes

      def initialize(config = {})
        @config = config
        @app_ports = app_ports
        @tunnel = Simulacrum::Browserstack::Tunnel.new(
          ENV['BROWSERSTACK_USERNAME'],
          ENV['BROWSERSTACK_APIKEY'],
          @app_ports
        )

        super()
        open_tunnel
        set_global_env
        start_timer
        execute
        summarize
      ensure
        @tunnel.close_tunnel
      end

      def execute
        @results = Parallel.map_with_index(test_browsers, in_processes: processes) do |(name, caps), index|
          begin
            configure_app_port(index)
            configure_environment(name, caps)
            run_suite
          rescue SystemExit
            exit 1
          ensure
            # TODO: this should have a more reliable way to check that the
            #       remote selenium endpoint has closed properly. Should this
            #       hit the API and check?
            #
            #       Possible to programatically access the Capybara session by
            #       using `name` - something like `Capybara.drivers[name]`
            sleep 1
          end
        end
      ensure
        stop_timer
      end

      private

      def start_timer
        @start_time = Time.now
      end

      def stop_timer
        @end_time = Time.now
      end

      def summarize
        summary = Simulacrum::Browserstack::Summary.new(@results,
                                                        @start_time,
                                                        @end_time)
        summary.dump_summary
        summary.dump_failures
      end

      def configure_app_port(index)
        ENV['APP_SERVER_PORT'] = app_ports[index].to_s
      end

      # rubocop:disable MethodLength
      def configure_environment(name, caps)
        # TODO: Make these ENV vars less sucky
        ENV['SELENIUM_REMOTE_URL']            = @tunnel.selenium_remote_url
        ENV['BS_DRIVER_NAME']                 = name
        ENV['SELENIUM_BROWSER']               = caps['browser']
        ENV['SELENIUM_VERSION']               = caps['browser_version']
        ENV['BS_AUTOMATE_OS']                 = caps['os']
        ENV['BS_AUTOMATE_OS_VERSION']         = caps['os_version']
        ENV['BS_AUTOMATE_RESOLUTION']         = caps['resolution']
        ENV['BS_AUTOMATE_REQUIREWINDOWFOCUS'] = caps['requireWindowFocus']
        ENV['BS_AUTOMATE_PLATFORM']           = caps['platform']
        ENV['BS_AUTOMATE_DEVICE']             = caps['device']
        ENV['BS_AUTOMATE_DEVICEORIENTATION']  = caps['deviceOrientation']
      end
      # rubocop:enable MethodLength

      def processes
        parallel? ? @config[:processes].to_i : 1
      end

      def test_browsers
        parallel? ? browsers : [browsers.first]
      end

      def set_global_env
        ENV['SELENIUM_REMOTE_URL'] = @tunnel.selenium_remote_url
      end

      def app_ports
        @app_ports ||= test_browsers.length.times.map { find_available_port }
      end

      def find_available_port
        server = TCPServer.new('127.0.0.1', 0)
        server.addr[1]
      ensure
        server.close if server
      end

      def parallel?
        @config.include?(:processes) && @config[:processes].to_i > 1
      end

      def browsers
        @browsers ||= begin
          browsers = YAML.load_file(
            Rails.root.join('config/browserstack.yml'),
            safe: true
          )
          browsers ['browsers']
        end
      end

      def open_tunnel
        @tunnel.open_tunnel
        sleep 0.1 until @tunnel.open?
      end
    end
  end
end

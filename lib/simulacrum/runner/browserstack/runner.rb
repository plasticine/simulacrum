# encoding: UTF-8
require_relative './capybara_patch'
require_relative './tunnel'
require_relative './summary'
require_relative './api'
require_relative '../base'
require 'simulacrum/driver/browserstack'
require 'parallel'
require 'curb'
require 'yaml'
require 'retries'

module Simulacrum
  module Runner
    # A Runner Class for Browserstack that handles creating a Browserstack
    # tunnel, closing it when done. Also handles running the suite in parallel.
    class BrowserstackRunner < Simulacrum::Runner::Base
      # Exception to indicate that Browserstack has no available sessions
      # to start a new test run, this is used inside a retries loop but will
      # be raised if maximum retries is exceeded
      class NoRemoteSessionsAvailable < RuntimeError; end

      attr_reader :app_ports

      def initialize
        start_timer

        @username = Simulacrum.runner_options.username
        @apikey = Simulacrum.runner_options.apikey
        @app_ports = app_ports
        @api = Simulacrum::Browserstack::API.new(@username, @apikey)
        @tunnel = Simulacrum::Browserstack::Tunnel.new(@username, @apikey, @app_ports)

        set_global_env
        execute
        summarize
      ensure
        @tunnel.close if @tunnel
      end

      def execute
        puts "Using Browserstack runner with #{processes} remote workers"
        puts
        @results = Parallel.map_with_index(browsers, in_processes: processes) do |(name, caps), index|
          begin
            ensure_available_remote_runner
            configure_app_port(index)
            configure_environment(name, caps)
            configure_browser_setting(name)
            run
          rescue SystemExit
            exit 1
          rescue Selenium::WebDriver::Error::UnknownError
            puts "Selenium::WebDriver::Error::UnknownError was raised"
          ensure
            Capybara.current_session.driver.browser.quit
          end
        end
      ensure
        stop_timer
      end

      def run
        super
        { results: dump_results }
      end

      private

      def configure_browser_setting(name)
        RSpec.configuration.around do |example|
          example.metadata[:browser] = name
          example.run
        end
      end

      def configure_rspec
        super
        RSpec.configuration.instance_variable_set(:@reporter, reporter)
      end

      def configure_driver
        Simulacrum::Driver::BrowserstackDriver.use
      end

      def reporter
        @reporter ||= RSpec::Core::Reporter.new(formatter)
      end

      def formatter
        @formatter ||= Simulacrum::Formatters::SimulacrumFormatter.new($stdout)
      end

      def dump_results
        Marshal.dump(formatter.output_hash)
      end

      def ensure_available_remote_runner
        puts 'ensure_available_remote_runner'
        with_retries(max_tries: 20, base_sleep_seconds: 0.5, max_sleep_seconds: 15) do
          remote_worker_available?
        end
      end

      def remote_worker_available?
        account_details = @api.account_details
        unless account_details.sessions_running < account_details.sessions_allowed
          fail NoRemoteSessionsAvailable
        end
      end

      def start_timer
        @start_time = Time.now
      end

      def stop_timer
        @end_time = Time.now
      end

      def summarize
        summary = Simulacrum::Browserstack::Summary.new(@results, @start_time, @end_time)
        summary.dump_summary
        summary.dump_failures
        summary.dump_pending
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
        ENV['SELENIUM_VERSION']               = caps['browser_version'].to_s
        ENV['BS_AUTOMATE_OS']                 = caps['os']
        ENV['BS_AUTOMATE_OS_VERSION']         = caps['os_version'].to_s
        ENV['BS_AUTOMATE_RESOLUTION']         = caps['resolution']
        ENV['BS_AUTOMATE_REQUIREWINDOWFOCUS'] = caps['requireWindowFocus'].to_s
        ENV['BS_AUTOMATE_PLATFORM']           = caps['platform']
        ENV['BS_AUTOMATE_DEVICE']             = caps['device']
        ENV['BS_AUTOMATE_DEVICEORIENTATION']  = caps['deviceOrientation']
        ENV['BS_BROWSERNAME']                 = caps['browserName']
        ENV['BS_REALMOBILE']                  = caps['realMobile'].to_s
      end
      # rubocop:enable MethodLength

      def processes
        Simulacrum.runner_options.max_processes || 2
      end

      def set_global_env
        ENV['SELENIUM_REMOTE_URL'] = @tunnel.selenium_remote_url
      end

      def app_ports
        @app_ports ||= begin
          if browsers.length
            browsers.length.times.map { find_available_port }
          else
            [find_available_port]
          end
        end
      end

      def find_available_port
        server = TCPServer.new('127.0.0.1', 0)
        server.addr[1]
      ensure
        server.close if server
      end

      def browsers
        @browsers ||= begin
          if Simulacrum.config_file?
            browsers = Simulacrum.config_file['browsers']
            browsers = browsers.select do |name, value|
              name == Simulacrum.runner_options.browser
            end if Simulacrum.runner_options.browser
            puts browsers.inspect
            browsers
          else
            fail 'DERP!'
          end
        end
      end
    end
  end
end

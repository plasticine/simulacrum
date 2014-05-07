# encoding: UTF-8
require_relative './tunnel'
require_relative './summary'
require_relative '../base'
require 'yaml'
require 'retries'

module Simulacrum
  module Runner
    # A Runner Class for Browserstack that handles creating a Browserstack
    # tunnel, closing it when done. Also handles running the suite in parallel.
    class BrowserstackRunner < Simulacrum::Runner::Base

      # Exception to indicate that Browserstack has no available sessions
      # to start a new test run
      class NoRemoteSessionsAvailable < RuntimeError; end

      attr_reader :app_ports

      def initialize(config = {})
        @username = ENV['BROWSERSTACK_USERNAME']
        @apikey = ENV['BROWSERSTACK_APIKEY']
        @config = config
        @app_ports = app_ports
        @tunnel = Simulacrum::Browserstack::Tunnel.new(@username, @apikey, @app_ports)

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
        @results = Parallel.map_with_index(browsers, in_processes: processes) do |(name, caps), index|
          begin
            ensure_available_remote_runner
            configure_app_port(index)
            configure_environment(name, caps)
            run_suite
          rescue SystemExit
            exit 1
          end
        end
      ensure
        stop_timer
      end

      private

      def ensure_available_remote_runner
        with_retries(max_tries: 10, base_sleep_seconds: 1, max_sleep_seconds: 5) do
          remote_worker_available?
        end
      end

      def plan_details
        curl = Curl::Easy.new('https://www.browserstack.com/automate/plan.json')
        curl.http_auth_types = :basic
        curl.username = @username
        curl.password = @apikey
        JSON.parse(curl.perform)
      end

      def remote_worker_available?
        plan = plan_details
        sessions_running = plan[:parallel_sessions_running].to_i
        sessions_max_allowed = plan[:parallel_sessions_max_allowed].to_i
        raise NoRemoteSessionsAvailable unless sessions_running < sessions_max_allowed
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
        1
      end

      def set_global_env
        ENV['SELENIUM_REMOTE_URL'] = @tunnel.selenium_remote_url
      end

      def app_ports
        @app_ports ||= begin
          if browsers.length
            browsers.length.times.map do
              find_available_port
            end
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
          if File.exist?(config_file_path)
            config = YAML.load_file(config_file_path, safe: true)
            puts config.inspect
            config['browserstack']
          else
            []
          end
        end
      end

      def config_file_path
        if defined? Rails
          Rails.root.join('.simulacrum.yml')
        else
          '.simulacrum.yml'
        end
      end

      def open_tunnel
        @tunnel.open_tunnel
        sleep 0.1 until @tunnel.open?
      end
    end
  end
end

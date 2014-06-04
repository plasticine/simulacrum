# encoding: UTF-8
require 'timeout'
require 'rbconfig'
require 'fileutils'

module Simulacrum
  module Browserstack
    # Class for handling Browserstack tunnel opening/closing/management
    class Tunnel
      include RbConfig

      attr_reader :selenium_remote_url, :pid, :ports, :open
      alias_method :open?, :open

      DEFAULT_OPTIONS = {
        skip_check: true,
        only_automate: false,
        verbose: false,
        force: true
      }

      def initialize(username, apikey, ports, options = {})
        @pid = nil
        @open = false
        @username = username
        @apikey = apikey
        @ports = ports
        @options = OpenStruct.new(DEFAULT_OPTIONS.clone.merge!(options))

        open
      end

      def selenium_remote_url
        "http://#{@username}:#{@apikey}@hub.browserstack.com/wd/hub"
      end

      def open
        ensure_browserstack_binary
        create_tunnel
        ensure_open
      end

      def close
        kill
      end

      private

      def ensure_browserstack_binary
        File.chmod(01777, binary_path) unless File.executable?(binary_path)
      end

      def create_tunnel
        @pid = fork { exec(command) }
      end

      def command
        cmd = [binary_path]
        cmd << '-skipCheck'    if @options.skip_check == true
        cmd << '-onlyAutomate' if @options.only_automate == true
        cmd << '-force'        if @options.force == true
        cmd << '-v'            if @options.verbose == true
        cmd << @apikey
        cmd << formatted_ports
        cmd.join(' ')
      end

      def platform_executable
        case RbConfig::CONFIG['host_os']
        when /linux|arch/i
          'BrowserStackLocal_linux_x64'
        when /darwin/i
          'BrowserStackLocal_osx'
        end
      end

      def binary_path
        File.join(Simulacrum.root, 'support', platform_executable)
      end

      def formatted_ports
        ports.map { |port| "localhost,#{port},0" }.join(',')
      end

      def kill
        Process.kill('TERM', @pid) if running?
      end

      def ensure_open
        Timeout.timeout(240) do
          sleep 0.1 until tunnel_has_opened?
        end
        @open = true
      rescue Timeout::Error
        exit(1)
      end

      def tunnel_has_opened?
        `curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:45691`.to_i == 200
      end

      def running?
        if @pid.nil?
          false
        else
          Process.getpgid(@pid)
          true
        end
      rescue Errno::ESRCH
        false
      end
    end
  end
end

require 'timeout'
require 'rbconfig'
require 'fileutils'

module Simulacrum
  module Browserstack
    include RbConfig

    class Tunnel
      attr_reader :selenium_remote_url, :pid, :ports

      DEFAULT_OPTIONS = {
        skip_check: true,
        only_automate: false,
        verbose: true,
        force: true,
      }

      def initialize(username, api_key, ports, options = {})
        @pid = nil
        @is_open = false
        @username = username
        @api_key = api_key
        @ports = ports
        @options = OpenStruct.new(DEFAULT_OPTIONS.clone.merge!(options))
      end

      def selenium_remote_url
        "http://#{@username}:#{@api_key}@hub.browserstack.com/wd/hub"
      end

      def open_tunnel
        ensure_browserstack_binary
        create_tunnel
        ensure_open
      end

      def close_tunnel
        kill
      end

      def is_open?
        @is_open
      end

      private

      def ensure_browserstack_binary
        FileUtils.mkdir_p(Rails.root.join('tmp', 'browserstack'))

        unless File.exist?(binary_path)
          FileUtils.cp(binary_path_for_platform, binary_path)
        end

        File.chmod(01777, binary_path) unless File.executable?(binary_path)
      end

      def binary_path
        Rails.root.join('tmp', 'browserstack', platform_executable)
      end

      def create_tunnel
        puts command
        @pid = fork { exec(command) }
      end

      def command
        cmd = [binary_path]
        cmd << '-skipCheck'    if @options.skip_check == true
        cmd << '-onlyAutomate' if @options.only_automate == true
        cmd << '-force'        if @options.force == true
        cmd << '-v'            if @options.verbose == true
        cmd << @api_key
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

      def binary_path_for_platform
        File.join(Simulacrum.root, 'support', platform_executable)
      end

      def formatted_ports
        ports.map {|port| "localhost,#{port},0" }.join(",")
      end

      def kill
        Process.kill('TERM', @pid) if running?
      end

      def ensure_open
        Timeout.timeout(240) do
          sleep 0.1 until tunnel_has_opened?
        end
        @is_open = true
      rescue Timeout::Error
        exit(1)
      end

      def tunnel_has_opened?
        x = `curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:45691`.to_i
        x == 200
      end

      def running?
        unless @pid.nil?
          Process.getpgid(@pid)
          true
        else
          false
        end
      rescue Errno::ESRCH
        false
      end
    end
  end
end

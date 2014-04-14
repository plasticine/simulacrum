require 'timeout'
require 'rbconfig'

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

      def open
        create
      end

      def close
        kill
      end

      def is_open?
        @is_open
      end

      private

      def create
        @pid = fork { exec(command) }
        ensure_open
      end

      def command
        cmd = ["#{Rails.root.join('spec/support/', executable)}"]
        cmd << '-skipCheck'    if @options.skip_check == true
        cmd << '-onlyAutomate' if @options.only_automate == true
        cmd << '-force'        if @options.force == true
        cmd << '-v'            if @options.verbose == true
        cmd << @api_key
        cmd << formatted_ports
        cmd.join(' ')
      end

      def executable
        case RbConfig::CONFIG['host_os']
          when /linux|arch/i
            'BrowserStackLocal_linux'
          when /darwin/i
            'BrowserStackLocal_osx'
        end
      end

      def formatted_ports
        ports.map {|port| "localhost,#{port},0" }.join(",")
      end

      def kill
        Process.kill('TERM', @pid) if running?
      end

      def ensure_open
        Timeout.timeout(10) do
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

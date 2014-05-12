# encoding: UTF-8
require 'optparse'
require 'ostruct'
require 'simulacrum'

module Simulacrum
  module CLI
    # Option parser for handling options passed into the Simulacrum CLI
    #
    # This class is mostly borrowed from Cane's Parser class. Thanks Xav! <3
    class Parser
      attr_reader :stdout

      # Exception to indicate that no further processing is required and the
      # program can exit. This is used to handle --help and --version flags.
      class OptionsHandled < RuntimeError; end

      def self.parse(args)
        new.parse(args)
      end

      def initialize(stdout = $stdout)
        @stdout = stdout

        add_banner
        add_runner_options
        add_format_options
        add_separator
        add_version
        add_help
      end

      def parse(args, _return = true)
        parser.parse!(args)
        options.files = args if args.size > 0
        options
      rescue OptionParser::InvalidOption,
             OptionParser::AmbiguousOption
        args = %w(--help)
        _return = false
        retry
      rescue OptionsHandled
        _return
      end

      private

      def add_banner
        parser.banner = 'Usage: simulacrum [options] [files or directories]'
        add_separator
      end

      def add_separator
        parser.separator ''
      end

      def add_version
        parser.on_tail('-v', '--version', 'Show version') do
          stdout.puts Simulacrum::VERSION
          fail OptionsHandled
        end
      end

      def add_help
        parser.on_tail('-h', '--help', 'Show this message') do
          stdout.puts parser
          fail OptionsHandled
        end
      end

      def add_runner_options
        parser.on('--runner [RUNNER]',
                  [:default, :browserstack],
                  'Runner to use for executing specs (local, browserstack).') do |runner|
          options.runner = runner
        end

        parser.on('--username [USERNAME]',
                  'Username for authenticating when using the Browserstack runner.') do |username|
          options.username = username
        end

        parser.on('--apikey [APIKEY]',
                  'API key for authenticating when using the Browserstack runner.') do |apikey|
          options.apikey = apikey
        end

        parser.on('--max-processes [N]',
                  Integer,
                  'Number of parallel proceses the runner should use.') do |max_processes|
          options.max_processes = max_processes
        end

        parser.on('--browser [BROWSER]',
                  'Browser configuration to use') do |browser|
          options.browser = browser.to_sym
        end
      end

      def add_format_options
        add_separator

        parser.on('-c',
                  '--[no-]color',
                  '--[no-]colour',
                  'Enable color in the output.') do |value|
          options.color = value
        end
      end

      def options
        @options ||= begin
          options = OpenStruct.new
          options.files = ['spec/ui']
          options.color = false
          options.runner = :default
          options
        end
      end

      def parser
        @parser ||= OptionParser.new
      end
    end
  end
end

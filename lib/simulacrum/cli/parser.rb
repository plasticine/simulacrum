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
        add_format_options
        add_separator
        add_version
        add_help
      end

      def parse(args, _return = true)
        parser.parse!(args)
        options['files'] = args if args.size > 0
        OpenStruct.new(default_options.merge(options))
      rescue OptionParser::InvalidOption,
             OptionParser::AmbiguousOption
        args = %w(--help)
        _return = false
        retry
      rescue OptionsHandled
        _return
      end

      private

      def default_options
        {}
      end

      def add_banner
        parser.banner = 'Usage: simulacrum [options] [files or directories]'
        add_separator
      end

      def add_separator
        parser.separator ''
      end

      def add_version
        parser.on_tail('--version', 'Show version') do
          stdout.puts Simulacrum::VERSION
          fail OptionsHandled
        end
      end

      def add_help
        parser.on_tail('-h', '--help', 'You\'re looking at it!') do
          stdout.puts parser
          fail OptionsHandled
        end
      end

      def add_format_options
        parser.on('-c',
                  '--[no-]color',
                  '--[no-]colour',
                  'Enable color in the output.') do |value|
          options['color'] = value
        end

        parser.on('-v',
                  '--verbose',
                  'Be more shouty.') do |value|
          options['verbose'] = value
        end
      end

      def options
        @options ||= begin
          options = {}
          options['files'] = ['spec/ui']
          options['color'] = false
          options['verbose'] = false
          options
        end
      end

      def parser
        @parser ||= OptionParser.new
      end
    end
  end
end

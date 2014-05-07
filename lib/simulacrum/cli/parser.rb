# encoding: UTF-8
require 'optparse'
require 'ostruct'
require 'simulacrum'

module Simulacrum
  # Option parser for handling options passed into the Simulacrum CLI
  #
  # This class is mostly borrowed from Cane's Parser class. Thanks Xav! <3
  module CLI
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

        add_options
        add_separator
        add_version
        add_help
      end

      def parse(args, _return = true)
        parser.parse!(args)
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

      def add_separator
        parser.separator ''
      end

      def add_version
        parser.on_tail('-v', '--version', 'Show version') do
          stdout.puts Simulacrum::VERSION
          raise OptionsHandled
        end
      end

      def add_help
        parser.on_tail('-h', '--help', 'Show this message') do
          stdout.puts parser
          raise OptionsHandled
        end
      end

      def add_options
        parser.on('--color', 'Colorize output') do |value|
          options.color = value
        end

        parser.on('--browserstack', 'Run specs against Browserstack') do |value|
          options.browserstack = value
        end
      end

      def options
        @options ||= begin
          options = OpenStruct.new
          options.color = false
          options.browserstack = false
          options
        end
      end

      def parser
        @parser ||= OptionParser.new
      end
    end
  end
end

# encoding: UTF-8
require 'simulacrum/cli/parser'

module Simulacrum
  # Command-line interface for driving Simulacrum
  module CLI
    def execute!(argv)
      Command.new(argv).run_and_exit
    end
    module_function :execute!

    # Class for wrappin up logic for running the process and handling exit
    class Command
      def initialize(argv, stdin = $stdin, stdout = $stdout, stderr = $stderr, kernel = Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end

      def run_and_exit
        @exit_code = run
        @kernel.exit(@exit_code)
      end

      private

      def run
        if parsed_argv == true
          0
        else
          Simulacrum.run(parsed_argv).exit_code
        end
      end

      def parsed_argv
        @parsed_argv ||= CLI::Parser.parse(@argv)
      end
    end
  end
end

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
      attr_reader :runner

      def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end

      def run_and_exit
        @kernel.exit(runner.exit_code)
      end

      private

      def runner
        @runner ||= Simulacrum.run(parse_argv)
      end

      def parse_argv
        CLI::Parser.parse(@argv)
      end
    end
  end
end

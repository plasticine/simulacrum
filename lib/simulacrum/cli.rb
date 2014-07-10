# encoding: UTF-8
require 'simulacrum/cli/parser'
require 'pry'

module Simulacrum
  # Command-line interface for driving Simulacrum
  module CLI
    def run(args)
      runner = Simulacrum.run(Parser.parse(args))
      exit runner.exit_code
    end
    module_function :run
  end
end

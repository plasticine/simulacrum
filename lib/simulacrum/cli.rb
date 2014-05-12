# encoding: UTF-8
require 'simulacrum/cli/parser'

module Simulacrum
  # Command-line interface for driving Simulacrum
  module CLI
    def run(args)
      runner_options = Parser.parse(args)
      Simulacrum.run(runner_options)
    end
    module_function :run
  end
end

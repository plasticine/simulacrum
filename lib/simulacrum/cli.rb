# encoding: UTF-8
require 'simulacrum/cli/parser'

module Simulacrum
  # Command-line interface for driving Simulacrum
  module CLI
    def run(args)
      Simulacrum.run(Parser.parse(args))
    end
    module_function :run
  end
end

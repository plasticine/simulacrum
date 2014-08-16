# encoding: UTF-8
require_relative './runner/base'

module Simulacrum
  # Provide methods for starting the correct runner runner
  module Runner
    def run
      case Simulacrum.runner_options.runner
      when nil
        Simulacrum::Runner::Base.new
      when :browserstack
        # Simulacrum::Runner::BrowserstackRunner.new
      end
    end
    module_function :run
  end
end

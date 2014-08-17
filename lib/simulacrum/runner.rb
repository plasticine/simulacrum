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
        Simulacrum::Runner.use_browserstack_runner
      end
    end
    module_function :run

    def use_browserstack_runner
      require 'simulacrum-browserstack'
      Simulacrum::Runner::BrowserstackRunner.new
    end
    module_function :use_browserstack_runner
  end
end

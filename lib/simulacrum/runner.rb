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
        Simulacrum::Runner.require_browserstack_runner
        # Simulacrum::Runner::BrowserstackRunner.new
      end
    end
    module_function :run

    def require_browserstack_runner
      require 'simulacrum-browserstack'
    rescue LoadError
      puts 'LoadError'
    end
    module_function :require_browserstack_runner
  end
end

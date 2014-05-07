# encoding: UTF-8
require_relative './runner/browserstack/runner'

module Simulacrum
  module Runner
    def run(options)
      puts options

      if options.browserstack
        Simulacrum::Runner::BrowserstackRunner.new
      end
    end
    module_function :run
  end
end

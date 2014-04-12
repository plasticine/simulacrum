require_relative '../simulacrum'
require_relative '../simulacrum/command'

module Simulacrum
  class CLI
    def self.start(*args)
      begin
        puts args
      rescue => error
        puts error
        exit(1)
      end
    end
  end
end

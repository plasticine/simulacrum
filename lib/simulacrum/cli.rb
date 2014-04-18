require 'optparse'
require_relative '../simulacrum'
require_relative '../simulacrum/command'
require_relative '../simulacrum/runners/browserstack/runner'

module Simulacrum
  class CLI
    def self.start(*args)
      begin
        options = {}
        OptionParser.new do |opts|
          opts.banner = "Usage: example.rb [options]"

          opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
            options[:verbose] = v
          end
        end.parse!

        p options
        p ARGV

        Simulacrum::Runners::BrowserstackRunner.new(processes: 5)
      rescue => error
        puts error
        exit(1)
      end
    end
  end
end

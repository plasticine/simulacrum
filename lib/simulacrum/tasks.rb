# encoding: UTF-8
require 'rake'

namespace :simulacrum do
  desc 'Run UI specs in parallel'
  task :spec do
    # TODO: this should use the `parallel_sessions_max_allowed` value from the
    #       Browserstack API
    Simulacrum::Runners::BrowserstackRunner.new(processes: 5)
  end
end

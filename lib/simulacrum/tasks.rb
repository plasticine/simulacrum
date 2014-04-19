require 'rake'

namespace :simulacrum do
  desc 'Run UI specs in parallel'
  task :spec do
    Simulacrum::Runners::BrowserstackRunner.new(processes: 5)
  end
end

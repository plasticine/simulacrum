require 'rake'

namespace :simulacrum do
  desc "Run UI specs"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/ui/**/*_spec.rb"
    t.rspec_opts = <<-SPEC_OPTS \
      --require simulacrum_helper \
      --format progress
    SPEC_OPTS
  end

  desc "Run UI specs in parallel"
  task :parallel do
    require "#{Rails.root}/spec/support/browserstack_runner"

    BrowserstackRunner.new(processes: 5) {
      Rake::Task['simulacrum:spec'].execute()
    }
  end
end

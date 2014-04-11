module Simulacrum
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require_relative "./simulacrum/tasks"
    end
  end
end

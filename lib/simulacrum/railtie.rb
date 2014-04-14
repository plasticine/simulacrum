module Simulacrum
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require_relative "./tasks"
    end
  end
end

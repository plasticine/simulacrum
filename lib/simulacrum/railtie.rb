# encoding: UTF-8
module Simulacrum
  # Railtie Class for Rails
  class Railtie < ::Rails::Railtie
    rake_tasks { require_relative './tasks' }
  end
end

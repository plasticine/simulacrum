# encoding: UTF-8
require 'sinatra/base'

# Fixture application
class FixtureApp < Sinatra::Application
  set :public_folder, File.dirname(__FILE__) + '/public'

  if app_file == $PROGRAM_NAME
    puts '[fixture app] Booting...' * 100
    run!
  end
end

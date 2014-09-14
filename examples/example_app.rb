require 'sinatra/base'

class ExampleApp < Sinatra::Application
  set :public_folder, File.dirname(__FILE__) + '/public'

  run! if app_file == $PROGRAM_NAME
end

require 'sinatra/base'

class ExampleApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
end

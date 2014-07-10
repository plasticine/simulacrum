require 'sinatra/base'

class FixtureApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
end

require 'sinatra/base'

# Fixture application
class FixtureApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
end

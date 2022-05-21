require 'sinatra/base'
require 'sinatra/reloader'

class UsersController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/api/v1/users' do
    User.all.to_json
  end
end

require 'sinatra/base'
require 'sinatra/reloader'

class UsersController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/api/v1/users' do
    User.all.to_json
  end

  get '/api/v1/users/:name' do
    user = User.find_by(name: params[:name])

    if user
      user.to_json
    else
      error 404, { error: 'user not found' }.to_json
    end
  end
end

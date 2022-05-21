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

  post '/api/v1/users' do
    user = User.new(user_params)

    if user.save
      user.to_json
    else
      error 400, user.errors.to_json
    end
  end

  put '/api/v1/users/:name' do
    user = User.find_by(name: params[:name])

    if user
      if user.update(user_params)
        user.to_json
      else
        error 400, user.errors.to_json
      end
    else
      error 404, { error: 'user not found' }.to_json
    end
  end

  delete '/api/v1/users/:name' do
    user = User.find_by(name: params[:name])

    if user
      user.destroy
      user.to_json
    else
      error 404, { error: 'user not found' }.to_json
    end
  end

  post '/api/v1/users/:name/sessions' do
    user = User.find_by(name: params[:name], password: user_params['password'])

    if user
      user.to_json
    else
      error 400, { error: 'invalid login credentials' }.to_json
    end
  end

  helpers do
    def user_params
      begin
        JSON.parse(request.body.read)
      rescue => e
        error 400, { message: 'Invalid JSON' }.to_json
      end
    end
  end
end

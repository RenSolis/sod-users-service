require 'sinatra/base'
require 'sinatra/reloader'

class Users < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/users' do
    'AAAAAAA causaaa'
  end
end

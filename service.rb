require 'sinatra/base'
require 'sinatra/reloader'

require './config/environment'

class Service < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello Renzo!'
  end
end

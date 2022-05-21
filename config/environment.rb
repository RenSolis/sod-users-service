ENV['SINATRA_ENV'] ||= 'development'

require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: "db/#{ENV['SINATRA_ENV']}.sqlite3" }

require './app/models/user'
require './app/controllers/users_controller'

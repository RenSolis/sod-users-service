ENV['SINATRA_ENV'] ||= 'development'

require 'sinatra/activerecord'

# ActiveRecord::Base.establish_connection(
#   adapter: 'sqlite3',
#   database: "db/#{ENV['SINATRA_ENV']}.sqlite3"
# )
set :database, { adapter: 'sqlite3', database: "db/development.sqlite3" }

require './app/models/user'

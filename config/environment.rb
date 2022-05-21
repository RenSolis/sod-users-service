ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

set :database, { adapter: 'sqlite3', database: "db/#{ENV['SINATRA_ENV']}.sqlite3" }

%w[controllers lib models].each do |directory|
  Dir["./app/#{directory}/*.rb"].each { |file| require file }
end

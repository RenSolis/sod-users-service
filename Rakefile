ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require './config/environment'
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require './config/environment'
  end
end

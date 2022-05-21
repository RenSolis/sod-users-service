require 'sinatra'
require './service'
require_relative 'app/controllers/users_controller'

use UsersController
run Service

require 'sinatra'
require './service'
require './config/environment'

use UsersController
run Service

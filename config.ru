require 'sinatra'
require './service'
require_relative 'app/controllers/users'

use Users
run Service

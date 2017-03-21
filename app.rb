# Author: Herminio Vazquez
# Date: March 21, 2017
# Project: ING Mortgages /  Force Application
# Location: Amsterdam, Netherlands
# File: app.rb
# Description: Web service to generate random people
# =====================================================

# docker-machine create -d virtualbox redis-server
# docker run -d --name redis-srv -p 6379:6369 redis
# VBoxManage controlvm "redis-server" natpf1 "tcp-port6379,tcp,,6379,,6379";

require 'sinatra'
require 'sinatra/json'
require 'redis'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  redis = Redis.new
  @people = redis.scard 'people'
  haml :index
end

get '/people' do
  redis = Redis.new
  counter = redis.scard 'people'
  key = redis.spop 'people'
  person = redis.hgetall(key)
  redis.del(key)
  json person.merge("counter":counter)
end

# Author: Herminio Vazquez
# Date: March 21, 2017
# Location: Amsterdam, Netherlands
# File: app.rb
# Description: Web service to generate random people
# =====================================================

# Docker Machine
# docker-machine create -d virtualbox redis-server
# =====================================================

# Docker
# docker run -d --name redis-srv -p 6379:6369 redis
# VBoxManage controlvm "redis-server" natpf1 "tcp-port6379,tcp,,6379,,6379";
# VBoxManage controlvm "redis-server" natpf1 "tcp-port4567,tcp,,4567,,4567";
# =====================================================


# Redis Operations
# docker exec -ti redis-srv bash
# redis-cli
# SADD people user:1
# HMSET user:1 name "John Smith" sofinummer 10203040 initials "J.S" sex Male phone 666777999 email jsmith@test.com street "5th Avenue" house 110 city "New York" regio "New Jersey" postcode 5533TH
# =====================================================

require 'sinatra'
require 'sinatra/json'
require 'redis'

set :public_folder, File.dirname(__FILE__) + '/static'
set :bind, '0.0.0.0'

get '/' do
  redis = Redis.new(:host => "redis-srv")
  @people = redis.scard 'people'
  haml :index
end

get '/people' do
  redis = Redis.new(:host => "redis-srv")
  counter = redis.scard 'people'
  key = redis.spop 'people'
  person = redis.hgetall(key)
  redis.del(key)
  json person.merge("counter":counter)
end

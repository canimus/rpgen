# Random Dutch Person Generator

This is a small project that uses a key-value store in Redis to retrieve unique generated person names with valid BSN numbers and addresses.

**Ruby Dependencies:**
- Ruby 2.3.3
- Sinatra 1.6
- Redis 3.3.3
- Haml 4.0.7

**JavaScript Dependencies:**
- Google Fonts
- D3.js Library

## Configuration
```ruby
# To get the libraries
bundle install
bundle package
```

## Run
```ruby
# To launch the service
bundle exec ruby app.rb
```

## View
```ruby
# Only on MacOS X
open "http://localhost:4567/"
```

## Docker Execution
If willing to run inside of the containers then first need to pull the right containers
```sh
# In your MacOS
docker-machine create -d virtualbox --virtualbox-share-folder "$(PWD)":/sw/apps redis-server
docker ssh redis-server

# Getting containers inside of virtualbox
docker pull redis
docker pull ruby:2.3.3

# Running the containers
docker run -d -p 6379:6379 --name redis-srv redis
docker run -it --rm --name randomperson --link redis-srv:redis-srv -p 4567:4567 -v "$PWD":/usr/src/myapp -w /usr/src/myapp ruby:2.3.
3 bash -c "bundle install --local && bundle exec ruby app.rb"
```

## Inserting records
The following commands are required to insert records
```redis
LPUSH people user:1
HMSET user:1 name "John Smith" sofinummer 10203040 initials "J.S" sex Male phone 666777999 email jsmith@test.com street "5th Avenue" house 110 city "New York" regio "New Jersey" postcode 55TH
```

source 'http://rubygems.org'

gem 'sinatra', :require => 'sinatra/base', :git => 'git://github.com/sinatra/sinatra.git'
gem 'mongoid', :git => 'git://github.com/gmanley/mongoid.git'
gem 'bson_ext'
gem 'haml'
gem 'json'
gem 'faye'
gem 'rake'
gem 'rack-flash'
gem 'thin'
gem 'mongoid_slug'

group :development do
  gem 'yui-compressor'
  gem 'heroku'
  gem 'sinatra-contrib', :git => 'git://github.com/sinatra/sinatra-contrib.git', :require => ['sinatra/reloader', 'sinatra/config_file']
end

group :test do
  gem 'rspec'
  gem 'capybara', :require => 'capybara/dsl'
  gem 'selenium'
  gem 'launchy'
end

group :development, :test do
  gem 'faker'
  gem 'machinist', '2.0.0.beta2'
  gem 'machinist_mongo', :require => 'machinist/mongoid', :git => 'git://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2'
  gem 'sham'
  gem 'rack-test', :require => 'rack/test'
end
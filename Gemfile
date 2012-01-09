source :rubygems

gem 'sinatra', :require => 'sinatra/base', :git => 'git://github.com/sinatra/sinatra.git'
gem 'mongoid', '~> 2.4'
gem 'bson_ext'
gem 'haml'
gem 'json'
gem 'faye'
gem 'rake'
gem 'rack-flash', :git => 'git://github.com/gmanley/rack-flash.git'
gem 'thin'
gem 'mongoid_slug'

group :development do
  gem 'pry', :git => 'git://github.com/pry/pry.git'
  gem 'heroku'
  gem 'sinatra-contrib', :git => 'git://github.com/gmanley/sinatra-contrib.git', :require => 'sinatra/reloader'
end

group :test do
  gem 'rspec'
  gem 'capybara', :require => 'capybara/dsl'
  gem 'launchy'
  gem 'capybara-webkit'
end

group :development, :test do
  gem 'faker'
  gem 'fabrication'
  gem 'rack-test', :require => 'rack/test'
end

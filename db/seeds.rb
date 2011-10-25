ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'
require File.dirname(__FILE__) + "/../lib/user"

config = YAML.load_file('config/config.yml')
SocketChat::App.setup_db(config)

User.create(email: "gray.manley@gmail.com", password: "password", password_confirmation: "password", first_name: "Grayson", last_name: "Manley")
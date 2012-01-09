APP_ROOT = File.expand_path('../../..', __FILE__)
APP_ENV = ENV['RACK_ENV'] ||= "development"

ENV['BUNDLE_GEMFILE'] = File.join(APP_ROOT, '/Gemfile')
require 'bundler/setup'
Bundler.require(:default, APP_ENV)

require 'yaml'
require 'uri'
require 'date'

Dir[File.join(APP_ROOT, "lib/**/*.rb")].each {|path| require path}
require File.join(APP_ROOT, 'app')

SocketChat.setup_database

Faye::Logging.log_level = :info
Server = Faye::RackAdapter.new(SocketChat::App,
  :mount => '/faye',
  :timeout => 30,
  :extensions => [ChatHistory.new, ActivityNotifier.new]
)

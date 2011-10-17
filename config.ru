$:.unshift(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

use Faye::RackAdapter, :mount => '/faye',
                       :timeout => 25

require 'app'
run SocketChat::App
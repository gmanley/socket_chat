$:.unshift(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'

server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 30, :port => 9001)

EM.run do
  thin = Rack::Handler.get('thin')
  thin.run(server, Port: 9001)
  thin.run(SocketChat::App, Port: 3000)
end


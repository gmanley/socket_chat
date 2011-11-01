$:.unshift(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'

Faye::Logging.log_level = :info
port = ENV['RACK_ENV'] == 'production' ? 80 : 3000
server = Faye::RackAdapter.new(SocketChat::App,
  :mount => '/faye',
  :timeout => 30,
  :port => port
)
server.add_extension(SocketChat::ChatHistory.new)

EM.run do
  thin = Rack::Handler.get('thin')
  thin.run(server, :Port => port)
end

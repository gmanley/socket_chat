$:.unshift(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'

Faye::Logging.log_level = :info
server = Faye::RackAdapter.new(SocketChat::App,
  :mount => '/faye',
  :timeout => 30,
  :port => 3000
)
server.add_extension(SocketChat::ChatHistory.new)

EM.run do
  thin = Rack::Handler.get('thin')
  thin.run(server, :Port => 3000)
end

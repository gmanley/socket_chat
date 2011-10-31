$:.unshift(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'

server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 30, :port => 9001)
EM.run do
  thin = Rack::Handler.get('thin')
  thin.run(SocketChat::App, :Port => 3000)
  thin.run(server, :Port => 9001)

  server.get_client.subscribe('/*') do |message|
    user = User.find(message["user"]["id"])
    logged_message = user.messages.new(:text => message["text"])
    logged_message.save!
  end
end

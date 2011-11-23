$LOAD_PATH.unshift(File.expand_path('..', __FILE__))
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'

Faye::Logging.log_level = :info
$server = Faye::RackAdapter.new(SocketChat::App,
  :mount => '/faye',
  :timeout => 30,
  :extensions => [SocketChat::ChatHistory.new, SocketChat::ActivityNotifier.new]
)

run $server
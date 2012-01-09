APP_ROOT = File.expand_path('../..', __FILE__)
ENV['RACK_ENV'] = 'test'

require File.join(APP_ROOT, 'lib/support/boot')
def app; SocketChat::App end
SocketChat.setup_database

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

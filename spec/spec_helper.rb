$:.unshift(File.expand_path('..', __FILE__), File.expand_path('../..', __FILE__))
ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'app'

config = YAML.load_file('config/config.yml')
SocketChat::App.setup_db(config)
require 'sham'
require 'fixtures/blueprints'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.before(:each) { Machinist.reset_before_test }
end

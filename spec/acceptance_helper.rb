require 'spec_helper'
require 'capybara/rspec'

$server = Faye::RackAdapter.new(SocketChat::App,
  :mount => '/faye',
  :timeout => 30,
  :extensions => [SocketChat::ChatHistory.new]
)

Capybara.app = $server
Capybara.current_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL
end

def sign_in(email, password)
  visit('/')
  within('#login') do
    fill_in('email', :with => email)
    fill_in('password', :with => password)
    click_button('Sign in')
  end
end
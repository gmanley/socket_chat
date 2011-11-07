require 'spec_helper'

Capybara.app = SocketChat::App
Capybara.current_driver = :akephalos

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
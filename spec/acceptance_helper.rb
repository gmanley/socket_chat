require 'spec_helper'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.configure do |config|
  config.save_and_open_page_path = File.join(APP_ROOT, 'tmp/capybara')
  config.app = Server
  config.javascript_driver = :webkit
  config.asset_root = Pathname(File.join(APP_ROOT, 'public'))
end

def sign_in(email, password)
  visit('/')
  within('#login') do
    fill_in('email', :with => email)
    fill_in('password', :with => password)
    click_on('Sign In')
  end
end

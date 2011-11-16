require 'acceptance_helper'

feature 'Users must login to see certain pages' do
  let(:user) { User.make!(:password => 'password') }
  let(:room) { Room.make! }

  background(:each) do
    visit '/user/logout'
  end

  scenario "when logged in a user may view a chat room" do
    sign_in(user.email, 'password')
    visit "/room/#{room.slug}"
    page.should have_selector('#messageContainer')
  end

  scenario "when logged out a user may not view a chat room" do
    visit "/room/#{room.slug}"
    page.should have_content('Please Sign In')
    page.should_not have_css('#messageContainer')
  end
end
require 'acceptance_helper'

feature 'Users must part of the room to access it' do
  let(:user) { Fabricate(:user) }
  let(:room) { Fabricate(:room) }

  background do
    sign_in(user.email, 'password')
  end

  scenario "when not member of a chat room it should be inaccessible" do
    visit "/room/#{room.slug}"
    page.should have_content('Please Sign In')
    page.should_not have_css('#messageContainer')
  end

  scenario "as a member of a chat room it should be accessible" do
    visit "/room/#{room.slug}"
    page.should have_selector('#messageContainer')
  end
end
require 'acceptance_helper'

feature 'Chat', :js => true do
  let!(:user) { Fabricate(:user) }
  let!(:room) { Fabricate(:room) }
  let(:message) { Fabricate.build(:message) }

  background do
    room.users << user
  end

  scenario "Posting a message" do
    sign_in(user.email, 'password')
    save_and_open_page

    visit "/room/#{room.slug}"

    within("#sendMessage") do
      fill_in('message', :with => message.text)
      click_button('Send')
    end

    find('.message:last-child .body').should have_content(message.text)
  end
end
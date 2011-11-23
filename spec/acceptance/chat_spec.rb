require 'acceptance_helper'

feature 'Chat' do
  let(:user) { User.make! }
  let(:room) { Room.make! }
  let(:message) { Message.make }

  background do
    sign_in(user.email, 'password')
  end

  scenario "Posting a message" do
    sign_in(user.email, 'password')

    visit "/room/#{room.slug}"

    within("#sendMessage") do
      fill_in('message', :with => message.text)
      click_button('Send')
    end

    find('.message:last-child .body').should have_content(message.text)
  end
end
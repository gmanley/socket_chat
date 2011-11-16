require 'acceptance_helper'

feature 'User can add messages' do
  let(:user) { User.make! }
  let(:room) { Room.make! }
  let(:message) { Message.make }

  background do
    sign_in(user.email, user.password)
  end

  scenario "in a chat room" do
    visit "/room/#{room.slug}"

    within("#sendMessage") do
      fill_in('message', :with => message.text)
      click_button('Send')
    end

    find('.message:last-child .body').should have_content(message.text)
  end
end
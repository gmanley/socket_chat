require File.dirname(__FILE__) + '/../acceptence_helper'

describe 'Pages that require login' do
  context 'a chatroom' do
    before :each do
      visit '/user/logout'
    end

    before :all do
      @user = User.make!
      @room = Room.make!
    end

    it "displays chat room if you're logged in" do
      sign_in(@user.email, @user.password)
      visit "/room/#{@room.slug}"
      page.should have_selector('#messageContainer')
    end

    it "displays error message if you're not logged in" do
      visit "/room/#{@room.slug}"
      page.should have_content('Please Sign In')
      page.should have_no_selector('#messageContainer')
    end
  end
end
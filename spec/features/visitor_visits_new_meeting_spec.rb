require 'rails_helper'

feature 'New meeting' do
  before :each do
    u = User.create(phone_number: "9991231234")
    create_cookie('ucd', u.code)
  end
  scenario 'user visits new meeting' do
    visit '/meetings/new'

    expect(page).to have_content("Artemis' Umbrella")
  end
  scenario 'user visits new meeting and gets redirected to status page if already has an active meeting', js: true do
    visit '/'
    fill_in 'meeting_nickname', with: "Turbo"
    fill_in 'meeting_phone_number', with: '0401231234'
    fill_in 'duration-input', with: '30'
    click_button 'startbutton'
    visit '/meetings/new'

    expect(page).to have_content('Informing your Artemis in')
  end
end

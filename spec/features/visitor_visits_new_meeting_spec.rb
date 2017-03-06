require 'rails_helper'

feature 'New meeting' do
  scenario 'user visits new meeting' do
    visit '/meetings/new'

    expect(page).to have_content("Artemis' Umbrella")
  end
  scenario 'user visits new meeting and gets redirected to status page if already has an active meeting', js: true do
    visit '/'
    fill_in 'meeting_nickname', with: "Turbo"
    fill_in 'meeting_phone_number', with: '0401231234'
    fill_in 'duration-input', with: '30'
    click_button 'Start timer'
    visit '/meetings/new'

    expect(page).to have_content('Informing your Artemis in')
  end
end

require 'rails_helper'

feature 'New meeting' do
  scenario 'user visits new meeting' do
    visit '/meetings/new'

    expect(page).to have_content('Brändinimi')
  end
  scenario 'user visits new meeting and gets redirected to status page if already has an active meeting' do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'meeting_duration', with: '30'
    click_button 'Start timer'
    visit '/meetings/new'

    expect(page).to have_content('Sending message at:')
  end
end
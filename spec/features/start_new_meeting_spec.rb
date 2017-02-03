require 'rails_helper'

feature 'When starting a new meeting' do
  scenario 'user can create a meeting' do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'duration-value', with: '30'
    click_button 'Start timer'

    expect(page).to have_content('Sending message at:')
  end
  scenario 'user sees manually input duration on status page', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'duration-value', with: '30'
    click_button 'Start timer'

    expect(page).to have_content('30 minutes')
  end

end
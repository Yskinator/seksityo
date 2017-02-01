require 'rails_helper'

feature 'Start new meeting' do
  scenario 'user creates meeting' do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'meeting_duration', with: '30'
    click_button 'Start timer'

    expect(page).to have_content('Meeting was successfully created.')
  end
end
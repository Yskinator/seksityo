require 'rails_helper'

feature 'Start new meeting' do
  scenario 'user creates meeting' do
    visit '/'
    fill_in 'Phone number', with: '0401234123'
    fill_in 'Duration', with: '30'
    click_button 'Create Meeting'

    expect(page).to have_content('Meeting was successfully created.')
  end
end
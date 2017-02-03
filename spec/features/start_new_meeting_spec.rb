require 'rails_helper'

feature 'When starting a new meeting' do
  scenario 'user can create a meeting' do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'duration-input', with: '30'
    click_button 'Start timer'

    expect(page).to have_content('Sending message at:')
  end
  scenario 'user sees manually input duration on status page', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'duration-input', with: '30'
    click_button 'Start timer'

    expect(page).to have_content('30 minutes')
  end
  scenario 'user sees selected 2h duration on status page', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    find('#select2h').click
    click_button 'Start timer'
    expect(page).to have_content('120 minutes')
  end
  scenario 'user sees selected 1h duration on status page', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    find('#select1h').click
    click_button 'Start timer'
    expect(page).to have_content('60 minutes')
  end
  scenario 'user sees selected 30min duration on status page', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    find('#select30m').click
    click_button 'Start timer'
    expect(page).to have_content('30 minutes')
  end
  scenario 'user selects duration and then manually enters one', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    find('#select30m').click
    fill_in 'duration-input', with: 75
    click_button 'Start timer'
    expect(page).to have_content('75 minutes')
  end
  scenario 'user manually enters duration and then selects one', js: true do
    visit '/'
    fill_in 'meeting_phone_number', with: '0401234123'
    fill_in 'duration-input', with: 75
    find('#select2h').click
    click_button 'Start timer'
    expect(page).to have_content('120 minutes')
  end
end
require 'rails_helper'

feature 'When on the status page' do
  before :each do
    visit '/meetings/new'
    fill_in 'meeting_nickname', with: 'Pekka'
    fill_in 'meeting_phone_number', with: 'test@gmail.com'
    fill_in 'duration-input', with: '111'
    click_button 'Start timer'
  end
  scenario 'user can press the ok button to get back to meeting creation page', js: true do
    click_button "I'm OK"
    expect(page).to have_content("Artemis' Umbrella")
  end
  scenario 'user can press the alert button and send an alert message', js: true do
      expect(page).to have_button("Send Alert!")
      click_button 'Send Alert!'
      sleep(0.1)
      open_email('test@gmail.com')
      expect(current_email).to have_content "is in trouble and needs help immediately."
    end
end

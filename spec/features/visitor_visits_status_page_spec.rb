require 'rails_helper'

feature 'When on the status page' do
  before :each do
    visit '/meetings/new'
    fill_in 'meeting_nickname', with: 'Pekka'
    fill_in 'meeting_phone_number', with: '0401231234'
    fill_in 'duration-input', with: '111'
    click_button 'startbutton'
  end
  scenario 'user can press the ok button to get back to meeting creation page', js: true do
    click_button "I'm OK"
    expect(page).to have_content("Artemis' Umbrella")
  end
  scenario 'user can press the alert button and send an alert message', js: true do
    expect(page).to have_button("Send Alert!")
    click_button 'Send Alert!'
    sleep(0.1)
    open_email('0401231234@textmagic.com')
    expect(current_email).to have_content "is in trouble and needs help immediately"
  end
  scenario 'user can see the confirmation page after pressing the alert button', js:true do
    expect(page).to have_button("Send Alert!")
    click_button 'Send Alert!'
    expect(page).to have_content("An alert has been sent to your Artemis")
  end
  scenario 'user can add more time to the meeting by pressing the add time -button', js:true do
    expect(page).to have_button("+ 10 minutes")
    click_button '+ 10 minutes'
    expect(page).to have_content("121")
  end
end

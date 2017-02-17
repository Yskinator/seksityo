require 'rails_helper'

describe 'Mailer' do
  before :each do
    clear_emails
    Delayed::Worker.delay_jobs = false
    visit '/meetings/new'
    fill_in 'meeting_nickname', with: 'Pekka'
    fill_in 'duration-input', with: '1'
  end

  after :each do
    Delayed::Worker.delay_jobs = true
  end

  it 'should send message when the timer goes off', js: true do
    fill_in 'meeting_phone_number', with: 'seksityo@gmail.com'
    click_button 'Start timer'
    sleep(0.1)
    open_email('seksityo@gmail.com')
    expect(current_email).to have_content "The assumed duration for Pekka's activity has passed."
  end
  it 'should send the email to the address specified by user', js: true do
    fill_in 'meeting_phone_number', with: 'tyoseksi@gmail.com'
    click_button 'Start timer'
    sleep(0.1)
    open_email('seksityo@gmail.com')
    expect(current_email).to be(nil)
  end
  it 'should send message when the alert button is pressed', js: true do
    fill_in 'meeting_phone_number', with: 'seksityo@gmail.com'
    click_button 'Start timer'
    expect(page).to have_button("Send Alert!")
    click_button 'Send Alert!'
    sleep(0.1)
    open_email('seksityo@gmail.com')
    expect(current_email).to have_content "is in trouble and needs help immediately."
  end
end

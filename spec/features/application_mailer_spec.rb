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
    fill_in 'meeting_phone_number', with: 'testi@testi.test'
    click_button 'Start timer'
    sleep(0.3)
    open_email('testi@testi.test')
    expect(current_email).to have_content "The assumed duration for Pekka's activity has passed."
  end
  it 'should send the email to the address specified by user', js: true do
    fill_in 'meeting_phone_number', with: 'testi2@testi.test'
    click_button 'Start timer'
    sleep(0.3)
    open_email('testi@testi.test')
    expect(current_email).to be(nil)
  end
end

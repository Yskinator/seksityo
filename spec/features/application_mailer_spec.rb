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
    fill_in 'meeting_phone_number', with: '0401231234'
    click_button 'Start timer'
    sleep(0.3)
    open_email('0401231234@textmagic.com')
    expect(current_email).to have_content "Timed message from"
  end
  it 'should send the email to the address specified by user', js: true do
    fill_in 'meeting_phone_number', with: '0401231234'
    click_button 'Start timer'
    sleep(0.3)
    open_email('0501231234@textmagic.com')
    expect(current_email).to be(nil)
  end
end

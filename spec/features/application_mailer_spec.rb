require 'rails_helper'

describe 'Mailer' do
  background do
    clear_emails
    visit
    # Will find an email sent to test@example.com
    # and set `current_email`
    open_email('seksityo@gmail.com')
  end

  it 'should send message when the timer goes off', js: true do
    visit '/meetings/new'
    fill_in 'meeting_nickname', with: 'Pekka'
    fill_in 'meeting_phone_number', with: 'seksityo@gmail.com'
    fill_in 'duration-input', with: '1'
    click_button 'Start timer'

    expect(page).to have_content('Sending message at:')
    true.should == false
  end
end
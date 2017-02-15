require 'rails_helper'

describe 'Mailer' do

  it 'should send message when the timer goes off', js: true do
    visit '/meetings/new'
    fill_in 'meeting_nickname', with: 'Pekka'
    fill_in 'meeting_phone_number', with: 'seksityo@gmail.com'
    fill_in 'duration-input', with: '1'
    click_button 'Start timer'
    # Will find an email sent to seksityo@gmail.com and set 'current_email'
    open_email('seksityo@gmail.com')
    expect(current_email).to have_content 'Assumed duration for friends activity has passed.'
  end
end
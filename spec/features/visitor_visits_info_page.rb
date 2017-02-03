require 'rails_helper'

feature 'Info page' do
  scenario 'user visits info page' do
    visit '/about'

    expect(page).to have_content('$Brändinimi')
    expect(page).to have_content('Lorem ipsum')
    expect(page).to have_css('img', text: 'logo_placeholder.png')
  end
end
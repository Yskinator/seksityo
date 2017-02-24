require 'rails_helper'

feature 'Info page' do
  scenario 'user visits info page' do
    visit '/about'

    expect(page).to have_content("Artemis' Umbrella")
    expect(page).to have_content('Lorem ipsum')
  end
end

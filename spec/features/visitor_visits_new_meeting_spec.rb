require 'rails_helper'

feature 'New meeting' do
  scenario 'user visits new meeting' do
    visit '/meetings/new'

    expect(page).to have_content('Brändinimi')
  end
end
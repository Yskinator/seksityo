require 'rails_helper'

feature 'Root redirection' do
  scenario 'user visits root' do
    visit '/'

    expect(page).to have_content('Nimi')
  end
end

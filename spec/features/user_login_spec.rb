require 'rails_helper'

feature 'GET /login' do
  scenario 'user attempts log in with invalid information' do
    visit login_path
    fill_in 'session[email]', with: ''
    fill_in 'session[password]', with: ''
    within 'form' do
      click_on 'Log in'
    end
    expect(page).to have_content('Invalid email/password')
    visit root_path
    expect(page).to_not have_content('Invalid email/password')
  end
end
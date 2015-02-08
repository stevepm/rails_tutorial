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

  scenario 'user logs in with correct information and logs out' do
    user = UsersFixture::create_user
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    within 'form' do
      click_on 'Log in'
    end
    expect(page).to_not have_link('Log in')
    expect(page).to have_link('Log out')
    expect(page).to have_link('Profile')
    click_on 'Log out'
    expect(page).to_not have_link('Log out')
    expect(page).to_not have_link('Profile')
    expect(page).to have_link('Log in')
    expect(current_path).to eq(root_path)
  end
end
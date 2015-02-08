require 'rails_helper'

feature 'GET /signup' do
  scenario 'enter incorrect signup information' do
    visit signup_path
    fill_in 'user[name]', with: ' '
    fill_in 'user[email]', with: 'invalid@email'
    fill_in 'user[password]', with: 'foo'
    fill_in 'user[password_confirmation]', with: 'bar'
    click_on 'Create my account'
    within '#error_explanation' do
      expect(page).to have_content 'The form contains 4 errors.'
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Email is invalid"
      expect(page).to have_content "Password confirmation doesn't match Password"
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end

  scenario 'enter correct signup information' do
    before_users = User.count
    visit signup_path
    fill_in 'user[name]', with: 'user'
    fill_in 'user[email]', with: 'valid@email.com'
    fill_in 'user[password]', with: 'foobar'
    fill_in 'user[password_confirmation]', with: 'foobar'
    click_on 'Create my account'

    after_users = User.count
    expect(after_users).to eq(before_users+1)
    expect(current_path).to eq(user_path(User.last))
  end
end
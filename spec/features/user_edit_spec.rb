require 'rails_helper'

feature 'GET /users/:id' do
  let(:user) { UsersFixture::create_user }

  context 'invalid information' do
    before do
      visit login_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      within 'form' do
        click_on 'Log in'
      end
      visit(edit_user_path(user))
    end
    scenario 'user tries to edit their information with invalid info' do
      fill_in 'user[email]', with: 'invalid_email'
      fill_in 'user[name]', with: '  '
      click_on 'Save changes'
      within '#error_explanation' do
        expect(page).to have_content 'The form contains 2 errors.'
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Email is invalid"
      end
    end
  end

  context 'valid information' do
    scenario 'user tries to edit their information with valid info with friendly forwarding' do
      visit(edit_user_path(user))
      visit login_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      within 'form' do
        click_on 'Log in'
      end
      expect(current_path).to eq(edit_user_path(user))
      new_email = "valid@valid.com"
      new_name = "valid"
      fill_in 'user[email]', with: new_email
      fill_in 'user[name]', with: new_name
      click_on 'Save changes'
      expect(page).to have_content('Profile updated')
      user.reload
      expect(user.email).to eq(new_email)
      expect(user.name).to eq(new_name)
    end
  end


end
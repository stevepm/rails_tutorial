require 'rails_helper'

feature 'GET /users/:id' do
  let(:user) { UsersFixture::create_user }

  before do
    visit ('/users/' + user.id.to_s + '/edit')
  end

  context 'invalid information' do
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
    scenario 'user tries to edit their information with valid info' do
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
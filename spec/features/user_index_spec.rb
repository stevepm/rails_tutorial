require 'rails_helper'

describe 'GET #index' do
  before do
    30.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    user = UsersFixture::create_user
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    within 'form' do
      click_on 'Log in'
    end
    visit users_path
  end
  it 'shows the users including pagination' do
    within 'ul.users' do
      User.paginate(page: 1).each do |user|
        expect(page).to have_content(user.name)
      end
    end
  end
end
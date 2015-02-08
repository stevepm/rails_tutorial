require 'rails_helper'

RSpec.describe "UsersFixture Signup", type: :request do
  describe "GET /signup" do

    it "invalid signup information" do
      get signup_path
      expect(response).to have_http_status(200)

      before_count = User.count
      post users_path, user: {
               name: "",
               email: "invalid",
               password: "foo",
               password_confirmation: "bar"
                     }
      after_count = User.count
      expect(before_count).to eq(after_count)
      assert_template('users/new')
      expect(is_logged_in?).to eq(false)
    end

    it "valid signup information" do
      get signup_path
      expect(response).to have_http_status(200)

      before_count = User.count
      post users_path, user: {
                         name: "valid",
                         email: "valid@valid.com",
                         password: "foobar",
                         password_confirmation: "foobar"
                     }
      after_count = User.count
      expect(after_count).to eq(before_count+1)
      expect(is_logged_in?).to eq(true)
    end
  end
end

require 'rails_helper'

RSpec.describe "Users Signup", type: :request do
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
    end
  end
end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
    end
  end

end

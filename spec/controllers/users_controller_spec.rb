require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  before do
    @user = UsersFixture::create_user
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
    end
  end

  context 'not logged in' do
    describe "GET #edit" do
      it 'should redirect to login_url if not logged in' do
        get :edit, id: @user
        expect(flash.empty?).to eq(false)
        assert_redirected_to login_url
      end
    end

    describe "PATCH #update" do
      it 'should redirect to login_url if not logged in' do
        patch :update, id: @user, user: {name: @user.name, email: @user.email}
        expect(flash.empty?).to eq(false)
        assert_redirected_to login_url
      end
    end
  end

end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  before do
    @user = UsersFixture::create_user(admin: true)
    @other_user = UsersFixture::create_user(name: 'other_user',
                                            email: 'other@other.com')
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
    end
  end

  context 'not logged in' do

    describe "GET #index" do
      it 'should redirect to login_url' do
        get :index
        assert_redirected_to login_url
      end
    end

    describe "GET #edit" do
      it 'should redirect to login_url' do
        get :edit, id: @user
        expect(flash.empty?).to eq(false)
        assert_redirected_to login_url
      end
    end

    describe "PATCH #update" do
      it 'should redirect to login_url' do
        patch :update, id: @user, user: {name: @user.name, email: @user.email}
        expect(flash.empty?).to eq(false)
        assert_redirected_to login_url
      end
    end

    describe "DELETE #destroy" do
      it 'redirects to login_url' do
        before_count = User.count
        delete :destroy, id: @user
        after_count = User.count
        expect(after_count).to eq(before_count)
        assert_redirected_to login_url
      end
    end
  end

  context 'logged in as wrong user/non-admin' do
    before do
      session[:user_id] = @other_user.id
    end
    describe "GET #edit" do
      it 'should redirect to root_url' do
        get :edit, id: @user
        expect(flash.empty?).to eq(true)
        assert_redirected_to root_url
      end
    end

    describe "PATCH #update" do
      it 'should redirect to root_url' do
        patch :update, id: @user, user: {name: @user.name, email: @user.email}
        expect(flash.empty?).to eq(true)
        assert_redirected_to root_url
      end
    end

    describe "DELETE #destroy" do
      it 'redirects to root_url' do
        before_count = User.count
        delete :destroy, id: @user
        after_count = User.count
        expect(after_count).to eq(before_count)
        assert_redirected_to root_url
      end
    end

  end

  context 'admin user' do

    before do
      session[:user_id] = @user.id
    end

    describe "DELETE #destroy" do
      it 'removes a user' do
        before_count = User.count
        delete :destroy, id: @other_user
        after_count = User.count
        expect(after_count).to eq(before_count - 1)
        assert_redirected_to users_url
      end
    end
  end


end

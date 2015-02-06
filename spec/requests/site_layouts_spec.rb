require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe "layout links" do
    it "has all of the layout links" do
      get root_path
      expect(response).to render_template("static_pages/home")
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
      get signup_path
      assert_select "title", full_title("Sign up")
    end
  end
end


module UserHelper
  include Capybara::DSL
  def self.log_in_as(user)
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    within 'form' do
      click_on 'Log in'
    end
  end
end

RSpec.configure do |config|
  config.include UserHelper, :type => :feature
end
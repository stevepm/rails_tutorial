module UsersFixture
  def self.create_user(options = {})
    default = {
        name: 'Steve',
        email: 'steve@steve.com',
        password: 'password',
        password_confirmation: 'password'
    }

    options = default.merge(options)

    User.create!(options)
  end
end
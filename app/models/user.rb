class User < ActiveRecord::Base
  before_save do
    self.email.downcase!
  end

  has_secure_password

  validates :name, presence: true, length: {maximum: 50}
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {
                with: valid_email_regex
            },
            uniqueness: {
                case_sensitive: false
            }
  validates :password, length: {minimum: 6}

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ?
          BCrypt::Engine::MIN_COST :
          BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
    end
  end
end

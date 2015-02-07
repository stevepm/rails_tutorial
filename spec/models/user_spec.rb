require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: "test", email: 'email@test.com') }

  it 'should be valid' do
    expect(user.valid?).to eq(true)
  end

  context 'user.name' do
    it 'can not be blank' do
      user.name = "   "
      expect(user.valid?).to eq(false)
    end

    it 'can not be more than 50 characters' do
      user.name = "a" * 51
      expect(user.valid?).to eq(false)
    end
  end

  context 'user.email' do
    it 'can not be blank' do
      user.email = "   "
      expect(user.valid?).to eq(false)
    end

    it 'can not be more than 255 characters' do
      user.email = "a" * 244 + "@example.com"
      expect(user.valid?).to eq(false)
    end

    it 'accepts valid email addresses' do
      valid_addresses = %w[user@example.com USER@foo.COM a_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]

      valid_addresses.each do |address|
        user.email = address
        expect(user.valid?).to eq(true)
      end
    end
    it "doesn't accept invalid email addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]

      invalid_addresses.each do |address|
        user.email = address
        expect(user.valid?).to eq(false)
      end
    end

    it "must be a unique email address" do
      dup_user = user.dup
      dup_user.email = user.email.upcase
      user.save
      expect(dup_user.valid?).to eq(false)
    end
  end
end

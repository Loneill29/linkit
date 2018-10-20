require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "Linkit User", email: "user@email.com", password: "password") }

  it { is_expected.to have_many(:posts) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@email.com").for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Linkit User", email: "user@email.com")
    end

    it "should format the user's name" do
      user.name = "linkit user"
      user.save
      expect(user.name).to eq("Linkit User")
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name: "", email: "user@email.com") }
    let(:user_with_invalid_email) { User.new(name: "Linkit User", email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end
end

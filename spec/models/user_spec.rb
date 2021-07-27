require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do

    it 'is valid when all fields are present & passwords match' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(@user).to be_valid
    end

    it 'is not valid when all fields are present & passwords do not match' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "22345678")
      @user.save
      expect(@user).not_to be_valid
    end

    it 'is not valid when user email already exists (not case-sensitive)' do
      @user1 = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user1.save
      @user2 = User.new(first_name: "Dron", last_name: "Moon", email: "Yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user2.save
      expect(@user2).not_to be_valid
    end

    it 'is not valid when the password is less than 6 characters' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save
      expect(@user).not_to be_valid
    end

    it 'is not valid when user first name is not present' do
      @user = User.new(first_name: nil, last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(@user).not_to be_valid
    end

    it 'is not valid when user last name is not present' do
      @user = User.new(first_name: "Dron", last_name: nil, email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(@user).not_to be_valid
    end

  end

  # add new authentification (class) method
  describe '.authenticate_with_credentials' do
    it 'is valid when the emails and passwords match' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      email = "yahoo@yahoo.com"
      password = "12345678"
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).not_to be_nil
    end
    it 'is not valid when the email does not exist in database' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      email = "oohay@yahoo.com"
      password = "12345678"
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to be_nil
    end

    it 'is not valid when the user passwords do not match' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      email = "yahoo@yahoo.com"
      password = "22345678"
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to be_nil
    end

    it 'is valid when the email contains spaces' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      email = "  yahoo@yahoo.com"
      password = "12345678"
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).not_to be_nil
    end

    it 'is valid when the cases do not match' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "yahoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      email = "yahOO@yahoo.com"
      password = "12345678"
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).not_to be_nil
    end

    it 'is valid when the cases do not match (Upper case in account email)' do
      @user = User.new(first_name: "Dron", last_name: "Moon", email: "YAhoo@yahoo.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      email = "yahOO@yahoo.com"
      password = "12345678"
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).not_to be_nil
    end
  end

end

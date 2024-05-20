require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before do 
      @user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end

    it 'is not valid without a first name' do
      @user.first_name = nil
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      @user.last_name = nil
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid without an email' do
      @user.email = nil
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a password' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid if password and password_confirmation do not match' do
      @user.password_confirmation = 'wrong_password'
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

   it 'is not valid with a duplicate email (case insensitive)' do
      @user.save
      another_user = User.new(
        first_name: 'Jane',
        last_name: 'Smith',
        email: 'JOHN.DOE@example.com',
        password: 'password',
        password_confirmation: 'password'
      )

      another_user.save
      expect(another_user.errors.full_messages).to include("Email has already been taken")
   end

    it 'is not valid with a password less than 6 characters' do
      @user.password = '123'
      @user.password_confirmation = '123'
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do 
      @user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'authenticates with valid credentials' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'does not authenticate with invalid credentials' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates with an email having leading/trailing spaces' do
      authenticated_user = User.authenticate_with_credentials('   john.doe@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates with email in different cases' do
      authenticated_user = User.authenticate_with_credentials('JOHN.DOE@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(@user)
    end
  end
end

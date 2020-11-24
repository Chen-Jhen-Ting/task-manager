require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate' do
    context ',with appropriate name, email and password' do
      let(:user) do
        User.new(
          name: '陳振庭',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvzxcv'
        )
      end

      it ', it should be ok' do
        expect(user).to be_valid
      end
    end

    context ',without name' do
      let(:user) do
        User.new(
          name: '',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvzxcv'
        )
      end

      it ', it should not be ok' do
        expect(user).not_to be_valid
      end
    end

    context ',with short name ( length < 2 )' do
      let(:user) do
        User.new(
          name: 'a',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvzxcv'
        )
      end

      it ', it should be ok' do
        expect(user).not_to be_valid
      end
    end

    context ',with name ( length = 2 )' do
      let(:user) do
        User.new(
          name: 'ab',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvzxcv'
        )
      end

      it ', it should be ok' do
        expect(user).to be_valid
      end
    end

    context ', without email' do
      let(:user) do
        User.new(
          name: '陳振庭',
          email: '',
          password: 'zxcvzxcv'
        )
      end

      it ', should not be ok' do
        expect(user).not_to be_valid
      end
    end

    context ', with incorrect email' do
      let(:user) do
        User.new(
          name: '陳振庭',
          email: 'zcxv',
          password: 'zxcvzxcv'
        )
      end

      it ', should not be ok' do
        expect(user).not_to be_valid
      end
    end

    context ', without password' do
      let(:user) do
        User.new(
          name: '陳振庭',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: ''
        )
      end

      it ', should not be ok' do
        expect(user).not_to be_valid
      end
    end

    context ', with too short password' do
      let(:user) do
        User.new(
          name: '陳振庭',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvz'
        )
      end
      
      it ', should not be ok' do
        expect(user).not_to be_valid
      end
    end
  end

  describe '.create' do
    context ', check whether user can be created' do
      before do
        @user = User.create(
          name: '陳振庭',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvzxcv'
        )
      end

      it ', should be ok' do
        expect(User.last).to eq(@user)
      end
    end
  end

  describe '#encrypt_password' do
    context ', before action will change password' do
      let(:user) do
        User.create(
          name: '陳振庭',
          email: 'zxcvzxcvzxcv@gmail.com',
          password: 'zxcvzxcv'
        )
      end
      
      it ', password will be encrypted' do
        expect(user.password).not_to eq('zxcvzxcv')
        expect(user.password).to eq(Digest::SHA1.hexdigest('zxcvzxcv'))
      end
    end
  end

  describe '#login' do
    before do 
      @user = User.create(
        name: '陳振庭',
        email: 'zxcvzxcvzxcv@gmail.com',
        password: 'zxcvzxcv'
      )
    end
    it 'with correct email and password' do
      login_user = User.login(email:'zxcvzxcvzxcv@gmail.com',password:'zxcvzxcv')
      expect(login_user.name).to eq(@user.name)
    end

    it 'with wrong email and password' do
      login_user = User.login(email:'zxcvvzxcv@gmail.com',password:'zxcvzxscv')
      expect(login_user).to eq(nil)
    end
  end
end

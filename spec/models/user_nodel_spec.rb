require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate' do
    context ',with appropriate name, email and password' do
      it ', it should be ok' do
        user = User.new(
          name: '陳振庭',
          email: 'zxcv@gmail.com',
          password: 'zxcvzxcv'
        )
        expect(user).to be_valid
      end
    end

    context ',without name' do
      it ', it should not be ok' do
        user = User.new(
          name: '',
          email: 'zxcv@gmail.com',
          password: 'zxcvzxcv'
        )
        expect(user).not_to be_valid
      end
    end

    context ',with short name ( length < 2 )' do
      it ', it should be ok' do
        user = User.new(
          name: 'a',
          email: 'zxcv@gmail.com',
          password: 'zxcvzxcv'
        )
        expect(user).not_to be_valid
      end
    end

    context ',with name ( length = 2 )' do
      it ', it should be ok' do
        user = User.new(
          name: 'ab',
          email: 'zxcv@gmail.com',
          password: 'zxcvzxcv'
        )
        expect(user).to be_valid
      end
    end

    context ', without email' do
      it ', should not be ok' do
        user = User.new(
          name: '陳振庭',
          email: '',
          password: 'zxcvzxcv'
        )
        expect(user).not_to be_valid
      end
    end

    context ', with incorrect email' do
      it ', should not be ok' do
        user = User.new(
          name: '陳振庭',
          email: 'zcxv',
          password: 'zxcvzxcv'
        )
        expect(user).not_to be_valid
      end
    end

    context ', without password' do
      it ', should not be ok' do
        user = User.new(
          name: '陳振庭',
          email: 'zxcv@gmail.com',
          password: ''
        )
        expect(user).not_to be_valid
      end
    end

    context ', with too short password' do
      it ', should not be ok' do
        user = User.new(
          name: '陳振庭',
          email: 'zxcv@gmail.com',
          password: 'zxcvz'
        )
        expect(user).not_to be_valid
      end
    end
  end

  describe '.create' do
    context ', check whether user can be created' do
      it ', should be ok' do
        user = User.create(
          name: '陳振庭',
          email: 'zxcv@gmail.com',
          password: 'zxcvzxcv'
        )
        expect(User.last).to eq(user)
      end
    end
  end

  describe '#encrypt_password' do
    context ', before action will change password' do
      it ', password will be encrypted' do
        user = User.create(
          name: '陳振庭',
          email: 'zxcv@gmail.com',
          password: 'zxcvzxcv'
        )
        expect(user.password).not_to eq('zxcvzxcv')
        expect(user.password).to eq(Digest::SHA1.hexdigest('zxcvzxcv'))
      end
    end
  end
end

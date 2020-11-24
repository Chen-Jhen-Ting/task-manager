require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do 
    User.create(
      name: 'tedbear',
      email: 'zxcvzxcvzxcv@gmail.com',
      password: 'zxcvzxcv'
    )
  end

  let(:params) do
    {
      user: {
        name: 'tedbear',
        email: 'zxcvzxcvzxcv@gmail.com',
        password: 'zxcvzxcv'
      }
    }
  end

  describe '#sign_in' do
    subject { get :sign_in }
    it 'the link should be ok' do
      expect(subject.status).to be 200
    end
  end
  
  describe '#login' do
    subject { post :login, params: params }
    context 'with correct email and password' do
      it 'should find user' do
        user
        expect(subject.status).to be 302
      end
    end
    
    context 'with wrong email and password' do
      let(:params) do
        {
          user:{
            email: 'zcvzxcv@gmail.com',
            password:'zxcvzc'
          }
        }
      end
      
      it 'should not find user' do
        expect(subject.status).to be 302
        expect(subject).to redirect_to(sign_in_users_path)
        expect(assigns[:user]).to be_nil
      end
    end
  end

  describe '#sign_up' do
    subject { get :sign_up }
    it 'the link should be ok' do
      expect(subject.status).to be 200
    end
  end

  describe '#create' do
    before do
      post :create, params: params
    end
    
    context 'with appropriate data' do
      it 'user should be created' do
        expect(subject.status).to be 302
        expect(User.last.name).to eq 'tedbear' 
      end
    end

    context ' with inappropriate data' do
      let(:params) do
        {
          user:{
            name: '陳庭',
            email: 'zcvzxcv@gmail.com',
            password:'zxcc'
          }
        }
      end
      it 'user should not be created' do
        expect(subject.status).to be 200
        expect(User.last.name).not_to eq '陳庭'
      end
    end
  end

  
  describe '#edit' do
    context 'after login' do
      before do
        session[:user_token] = user.id
        get :edit 
      end
      it 'current user should be exist' do
        expect(subject.status).to be 200
      end
    end
  end

  describe '#update' do
    context 'after login' do
      let(:params) do
        {
          id: user.id,
          user: {
            name: '陳振庭',
            email: 'zxcvzxcvzxcv@gmail.com',
            password: 'zxcvzxcv'
          }
        }
      end

      before do
        session[:user_token] = user.id
        patch :update, params: params
      end

      it 'user data will change' do
        expect(subject.status).to be 302
        expect(user.reload.name).to eq('陳振庭')
      end
    end
  end

  describe '#sign_out' do

    before do
      session[:user_token] = user.id
      delete :sign_out 
    end

    it 'user can sign out' do
      expect(subject.status).to be 302
      expect(session[:user_token]).to be_nil
    end
  end
end

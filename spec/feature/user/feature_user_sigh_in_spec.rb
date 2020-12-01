require 'rails_helper'

RSpec.feature 'sign_up', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user sign up' do
    before do
      @user = User.create(
        name: '陳振庭',
        email: 'zxcvzxcvzxcv@gmail.com',
        password: 'zxcvzxcv'
      )
    end

    before do
      visit root_path
      # check User number

      expect(page).to have_content 'sign up'
      expect(page).to have_content 'sign in'
      expect(page).to have_content 'sign out'

      find('#sign_in_link').click

      expect(page).to have_content 'Email'
      expect(page).to have_content 'Password'
    end

    context 'sign in with correct infomation' do
      it 'user can login' do
        fill_in('Email', with:'zxcvzxcvzxcv@gmail.com')
        fill_in('Password', with:'zxcvzxcv')
        find('#sign_in_btn').click 

        expect(page).to have_content 'succeed to login'
      end
    end
  end
end
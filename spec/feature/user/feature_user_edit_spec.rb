require 'rails_helper'

RSpec.feature 'edit', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user edit profile' do
    before do
      @user = User.create(
        name: '陳振庭',
        email: 'zxcvzxcvzxcv@gmail.com',
        password: 'zxcvzxcv'
      )
    end

    context 'after login, user can change profile' do
      before do
        visit root_path
        expect(page).to have_content 'sign in'
        find('#sign_in_link').click
        fill_in('Email', with:'zxcvzxcvzxcv@gmail.com')
        fill_in('Password', with:'zxcvzxcv')
        find('#sign_in_btn').click 
        find('#user_edit_link').click
      end
      it 'user info can be change' do
        fill_in('Email', with:'abcabc@gmail.com')
        find('#update_btn').click
        expect(page).to have_content 'succeed to update'
        expect(User.find_by(email: 'abcabc@gmail.com').name).to eq '陳振庭'
      end
    end
  end
end
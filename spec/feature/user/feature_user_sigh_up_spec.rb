require 'rails_helper'

RSpec.feature 'sign_up', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user sign up' do
    before do
      visit root_path
      # check User number

      expect(User.count).to eq 1

      expect(page).to have_content 'sign up'
      expect(page).to have_content 'sign in'
      expect(page).to have_content 'sign out'

      find('#sign_up_link').click

      expect(page).to have_content 'Name'
      expect(page).to have_content 'Email'
      expect(page).to have_content 'Password'
    end

    context 'with all correct infomation' do
      it 'user can be created' do
        fill_in('Name', with:'陳振庭')
        fill_in('Email', with:'te@gmail.com')
        fill_in('Password', with:'123456123456')

        find('#sign_up_btn').click 

        expect(User.count).to eq 2

        expect(page).to have_content 'succeed to sign up'
      end
    end


    
  end
end
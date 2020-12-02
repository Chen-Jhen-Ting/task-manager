require 'rails_helper'

RSpec.feature 'sign_out', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user sign out' do
    before do
      visit root_path
      expect(page).to have_content 'sign up'
      expect(page).to have_content 'sign in'
      expect(page).to have_content 'sign out'
    end

    context 'user sign out' do
      it 'session will be nil' do
        find('#sign_out_link').click
        expect(page).to have_content 'sign out!'
      end
    end
  end
end
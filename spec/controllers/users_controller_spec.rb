require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#sign_in' do
    subject {get :sign_in}
    it 'the link should be ok' do
      expect(subject.status).to be 200
    end
  end

  describe '#sign_up' do
    subject {get :sign_up}
    it 'the link should be ok' do
      expect(subject.status).to be 200
    end
  end

end

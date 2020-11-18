require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '.index' do
    context '' do
      subject { get :index }
      it 'ok' do
        expect(subject.status).to be 200
      end
    end
  end
end

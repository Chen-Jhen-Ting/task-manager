require 'rails_helper'

RSpec.describe 'homepage', type: :routing do
  describe '.index, homepage' do
    it 'should be OK ' do
      expect(:get => "/").to route_to("home#index")
    end
  end
end

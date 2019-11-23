require 'spec_helper'

describe OrderCommission do
  describe described_class.new(order_price: 100.0, rating: 3, rainy: false) do
    it { is_expected.to respond_to(:order_price) }
    it { is_expected.to respond_to(:rating) }
    it { is_expected.to respond_to(:rainy) }
  end

  describe 'No rainy day commission' do
    it 'should have commission of 5.0 when order is menu_individual and rating is 3' do
      commission = described_class.new(order_price: 100.0, rating: 3, rainy: false)
      expect(commission.calculate).to eq 5.0
    end
  end
end

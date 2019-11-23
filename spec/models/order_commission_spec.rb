require 'spec_helper'

describe OrderCommission do
  describe described_class.new(order_price: 100.0, rating: 3, rainy: false) do
    it { is_expected.to respond_to(:order_price) }
    it { is_expected.to respond_to(:rating) }
    it { is_expected.to respond_to(:rainy) }
  end

  describe 'No rainy day and default rating' do
    it 'should be 5.0 when order is menu_individual and rating is 3' do
      commission = described_class.new(order_price: 100.0, rating: 3, rainy: false)
      expect(commission.calculate).to eq 5.0
    end

    it 'should be 8.75 when order is menu_pareja and rating is 3' do
      commission = described_class.new(order_price: 175.0, rating: 3, rainy: false)
      expect(commission.calculate).to eq 8.75
    end

    it 'should be 12.5 when order is menu_familiar and rating is 3' do
      commission = described_class.new(order_price: 250.0, rating: 3, rainy: false)
      expect(commission.calculate).to eq 12.5
    end
  end

  describe 'No rainy day and rating is 1' do
    it 'should be 3.0 when order is menu_individual and rating is 1' do
      commission = described_class.new(order_price: 100.0, rating: 1, rainy: false)
      expect(commission.calculate).to eq 3.0
    end

    it 'should be 5.25 when order is menu_pareja and rating is 1' do
      commission = described_class.new(order_price: 175.0, rating: 1, rainy: false)
      expect(commission.calculate).to eq 5.25
    end

    it 'should be 7.5 when order is menu_familiar and rating is 1' do
      commission = described_class.new(order_price: 250.0, rating: 1, rainy: false)
      expect(commission.calculate).to eq 7.5
    end
  end

  describe 'No rainy day and rating is 5' do
    it 'should be 7.0 when order is menu_individual and rating is 5' do
      commission = described_class.new(order_price: 100.0, rating: 5, rainy: false)
      expect(commission.calculate).to eq 7.0
    end

    it 'should be 12.25 when order is menu_pareja and rating is 5' do
      commission = described_class.new(order_price: 175.0, rating: 5, rainy: false)
      expect(commission.calculate).to eq 12.25
    end

    it 'should be 17.5 when order is menu_familiar and rating is 5' do
      commission = described_class.new(order_price: 250.0, rating: 5, rainy: false)
      expect(commission.calculate).to eq 17.5
    end
  end
end

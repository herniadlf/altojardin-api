require 'spec_helper'
require_relative '../../app/models/weather'
require_relative '../../app/repositories/weather_repository'

describe OrderCommission do
  describe described_class.new(order_price: 100.0, rating: 3) do
    it { is_expected.to respond_to(:order_price) }
    it { is_expected.to respond_to(:rating) }
  end

  describe 'No rainy day and default rating' do
    before(:each) do
      WeatherRepository.new.delete_all
      WeatherRepository.new.save(Weather.new(date: Date.today.to_s, rain: false))
    end

    it 'should be 5.0 when order is menu_individual and rating is 3' do
      commission = described_class.new(order_price: 100.0, rating: 3, status: 4)
      expect(commission.calculate).to eq 5.0
    end

    it 'should be 8.75 when order is menu_pareja and rating is 3' do
      commission = described_class.new(order_price: 175.0, rating: 3, status: 4)
      expect(commission.calculate).to eq 8.75
    end

    it 'should be 12.5 when order is menu_familiar and rating is 3' do
      commission = described_class.new(order_price: 250.0, rating: 3, status: 4)
      expect(commission.calculate).to eq 12.5
    end
  end

  describe 'No rainy day and rating is 1' do
    before(:each) do
      WeatherRepository.new.delete_all
      WeatherRepository.new.save(Weather.new(date: Date.today.to_s, rain: false))
    end

    it 'should be 3.0 when order is menu_individual and rating is 1' do
      commission = described_class.new(order_price: 100.0, rating: 1, status: 4)
      expect(commission.calculate).to eq 3.0
    end

    it 'should be 5.25 when order is menu_pareja and rating is 1' do
      commission = described_class.new(order_price: 175.0, rating: 1, status: 4)
      expect(commission.calculate).to eq 5.25
    end

    it 'should be 7.5 when order is menu_familiar and rating is 1' do
      commission = described_class.new(order_price: 250.0, rating: 1, status: 4)
      expect(commission.calculate).to eq 7.5
    end
  end

  describe 'No rainy day and rating is 5' do
    before(:each) do
      WeatherRepository.new.delete_all
      WeatherRepository.new.save(Weather.new(date: Date.today.to_s, rain: false))
    end

    it 'should be 7.0 when order is menu_individual and rating is 5' do
      commission = described_class.new(order_price: 100.0, rating: 5, status: 4)
      expect(commission.calculate).to eq 7.0
    end

    it 'should be 12.25 when order is menu_pareja and rating is 5' do
      commission = described_class.new(order_price: 175.0, rating: 5, status: 4)
      expect(commission.calculate).to eq 12.25
    end

    it 'should be 17.5 when order is menu_familiar and rating is 5' do
      commission = described_class.new(order_price: 250.0, rating: 5, status: 4)
      expect(commission.calculate).to eq 17.5
    end
  end

  describe 'Rainy day' do
    before(:each) do
      WeatherRepository.new.delete_all
      WeatherRepository.new.save(Weather.new(date: Date.today.to_s, rain: true))
    end

    it 'should be 8.0 when order is menu_individual and rating is 5' do
      commission = described_class.new(order_price: 100.0, rating: 5, status: 4)
      expect(commission.calculate).to eq 8.0
    end

    it 'should be 6.0 when order is menu_individual and rating is 3' do
      commission = described_class.new(order_price: 100.0, rating: 3, status: 4)
      expect(commission.calculate).to eq 6
    end

    it 'should be 4.0 when order is menu_individual and rating is 1' do
      commission = described_class.new(order_price: 100.0, rating: 1, status: 4)
      expect(commission.calculate).to eq 4
    end
  end

  describe 'Order status not delivered' do
    before(:each) do
      WeatherRepository.new.delete_all
      WeatherRepository.new.save(Weather.new(date: Date.today.to_s, rain: true))
    end

    it 'should raise an exception when order is not delivered' do
      commission = described_class.new(order_price: 100.0, rating: 5, status: 3)
      expect { commission.calculate }.to raise_error(CommissionException)
    end
  end
end

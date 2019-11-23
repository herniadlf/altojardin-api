require 'spec_helper'

describe OrderCommission do
  describe described_class.new(order_price: 100.0, rating: 5, rainy: false) do
    it { is_expected.to respond_to(:order_price) }
    it { is_expected.to respond_to(:rating) }
    it { is_expected.to respond_to(:rainy) }
  end
end

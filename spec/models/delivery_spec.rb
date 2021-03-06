require 'spec_helper'

describe Delivery do
  describe described_class.new(username: 'Carlos') do
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:available) }
    it { is_expected.to respond_to(:occupied_quantity) }
    it { is_expected.to respond_to(:orders_done_today) }
  end
end

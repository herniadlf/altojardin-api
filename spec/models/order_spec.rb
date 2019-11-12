require 'spec_helper'

describe Order do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:menu) }
    it { is_expected.to respond_to(:status) }

    it 'initial status should be received' do
      order = described_class.new({})
      expect(order.status).to eq OrderStatus::RECEIVED
    end
  end
end

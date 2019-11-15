require 'spec_helper'

describe Order do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:menu) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:assigned_to) }

    it 'initial status should be received' do
      order = described_class.new({})
      expect(order.status).to eq OrderStatus::RECEIVED
    end

    it 'should fail on status value not included' do
      order = described_class.new(user_id: 1, menu: 'menu_individual', status: 10)
      expect(order.valid?).to eq false
      expect(order.errors[:status].first).to eq 'invalid_status'
    end
  end

  describe 'status observer' do
    before(:each) do
      client = Client.new(username: 'username', address: 'Paseo Colon 111', phone: '1234-1243')
      ClientRepository.new.save(client)
    end

    let(:order) do
      client = ClientRepository.new.first
      described_class.new(user_id: client.user_id, menu: 'menu_individual')
    end

    it 'should observe in progress status' do
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('en_preparacion')
      expect(order.status).to eq OrderStatus::IN_PROGRESS
    end

    it 'should observe in transit status' do
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('en_entrega')
      expect(order.status).to eq OrderStatus::IN_TRANSIT
    end

    it 'should observe delivered status' do
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('entregado')
      expect(order.status).to eq OrderStatus::DELIVERED
    end
  end
end

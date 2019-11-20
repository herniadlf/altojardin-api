require 'spec_helper'
require_relative '../../app/exceptions/order_not_delivered'

describe Order do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:menu) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:assigned_to) }
    it { is_expected.to respond_to(:weight) }
    it { is_expected.to respond_to(:rating) }

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
    let(:delivery) do
      delivery = Delivery.new(username: 'kitopizzass')
      DeliveryRepository.new.save(delivery)
      delivery
    end

    it 'should observe in progress status' do
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('en_preparacion')
      expect(order.status).to eq OrderStatus::IN_PROGRESS
    end

    it 'should have waiting status if no deliveries are available when status goes in transit' do
      delivery.available = false
      DeliveryRepository.new.save(delivery)
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('en_entrega')
      expect(order.status).to eq OrderStatus::WAITING
    end

    it 'should have in transit status if a delivery is available when status goes in transit' do
      expect(delivery.available).to eq true
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('en_entrega')
      expect(order.status).to eq OrderStatus::IN_TRANSIT
    end

    it 'should be assigned to delivery' do
      expect(delivery.available).to eq true
      order.update_status('en_entrega')
      expect(order.status).to eq OrderStatus::IN_TRANSIT
      expect(order.assigned_to).to eq delivery.id
    end

    it 'should observe delivered status' do
      expect(order.status).to eq OrderStatus::RECEIVED
      order.update_status('entregado')
      expect(order.status).to eq OrderStatus::DELIVERED
    end

    it 'should rate order' do
      order.update_status('entregado')
      order.rate(2)
      expect(order.rating).to eq 2
    end

    it 'should raise order not delivered' do
      order.update_status('en_entrega')
      expect { order.rate(2) }.to raise_error(OrderNotDelivered)
    end
  end
end

require 'spec_helper'
require_relative '../../app/exceptions/order_exception'
require_relative '../../app/exceptions/order_status_exception'

describe Order do
  let(:delivery) do
    delivery = Delivery.new(username: 'kitopizzass')
    DeliveryRepository.new.save(delivery)
    delivery
  end
  let(:order) do
    client = ClientRepository.new.first
    described_class.new(user_id: client.user_id, menu: 'menu_individual', status: received_status)
  end
  let(:received_status) { OrderStatusReceived.new }

  before(:each) do
    client = Client.new(username: 'username', address: 'Paseo Colon 111', phone: '1234-1243')
    ClientRepository.new.save(client)
  end

  describe described_class.new(user_id: 1, menu: 'menu_individual',
                               status: OrderStatusReceived.new) do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:menu) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:assigned_to) }
    it { is_expected.to respond_to(:weight) }
    it { is_expected.to respond_to(:rating) }
  end

  describe 'validations' do
    let(:received_status) { OrderStatusReceived.new }

    it 'initial status should be received' do
      order = described_class.new(user_id: 1, menu: 'menu_individual', status: received_status)
      expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
    end

    it 'should fail on status value not included' do
      expect do
        described_class.new(user_id: 1, menu: 'menu_individual')
      end.to raise_error(InvalidStatusException)
    end
  end

  describe 'status changes' do
    it 'should change to in progress status' do
      expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
      order.update_status('en_preparacion')
      expect(order.status.id).to eq OrderStatusInProgress::IN_PROGRESS_ID
    end

    it 'should have waiting status if no deliveries are available when status goes in transit' do
      delivery.available = false
      DeliveryRepository.new.save(delivery)
      expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
      order.update_status('en_entrega')
      expect(order.status.id).to eq OrderStatusWaiting::WAITING_ID
    end

    it 'should have in transit status if a delivery is available when status goes in transit' do
      expect(delivery.available).to eq true
      expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
      order.update_status('en_entrega')
      expect(order.status.id).to eq OrderStatusInTransit::IN_TRANSIT_ID
    end

    it 'should be assigned to delivery' do
      expect(delivery.available).to eq true
      order.update_status('en_entrega')
      expect(order.status.id).to eq OrderStatusInTransit::IN_TRANSIT_ID
      expect(order.assigned_to).to eq delivery.id
    end

    it 'should change to delivered status' do
      expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
      order.update_status('entregado')
      expect(order.status.id).to eq OrderStatusDelivered::DELIVERED_ID
    end

    it 'should change to cancelled status' do
      expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
      order.cancel
      expect(order.status.id).to eq OrderStatusCancelled::CANCELLED_ID
    end

    it 'should not cancel order if its in transit' do
      expect(delivery.available).to eq true
      order.update_status('en_entrega')
      expect do
        order.cancel
      end.to raise_error(CannotCancelOrderException)
    end

    it 'should not cancel order if its delivered' do
      expect(delivery.available).to eq true
      order.update_status('entregado')
      expect do
        order.cancel
      end.to raise_error(CannotCancelOrderException)
    end

    it 'should not cancel order if its waiting' do
      expect(delivery.available).to eq true
      order.update_status('en_espera')
      expect do
        order.cancel
      end.to raise_error(CannotCancelOrderException)
    end
  end

  describe 'rating' do
    it 'should rate order' do
      order.update_status('entregado')
      order.rate(2)
      expect(order.rating).to eq 2
    end

    it 'should raise order not delivered if order is in en_entrega' do
      order.update_status('en_entrega')
      expect { order.rate(2) }.to raise_error(OrderNotDelivered)
    end

    it 'should raise rating not valid for rating 6' do
      order.update_status('entregado')
      expect { order.rate(6) }.to raise_error(RatingRangeNotValid)
    end
  end
end

require 'spec_helper'
require_relative '../../app/repositories/client_repository'
require_relative '../../app/models/order'
require_relative '../../app/exceptions/order_exception'

describe Client do
  describe described_class.new(username: 'Carlos') do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:username) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:address) }
    it { is_expected.to respond_to(:user_id) }
  end

  it 'should not be valid with an invalid phone' do
    client = described_class.new(username: 'Carlos', phone: 'abcd-4123')
    expect(client.valid?).to be false
    match = client.errors.messages[:phone].any? { |error| error == 'invalid_phone' }
    expect(match).to be true
  end

  it 'should not be valid with an address like "abc123"' do
    client = described_class.new(username: 'Carlos', address: 'abc123')
    expect(client.valid?).to be false
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be true
  end

  it 'should not be valid with an address like "asd"' do
    client = described_class.new(username: 'Carlos', address: 'asd')
    expect(client.valid?).to be false
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be true
  end

  it 'should be valid with an address like "Corrientes 1847"' do
    client = described_class.new(username: 'Carlos', phone: '4444-4123', address: 'Corrientes 1847')
    expect(client.valid?).to be true
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be false
  end

  describe 'model actions' do
    let(:client) do
      client = described_class.new(
        username: 'un_nombre', phone: '4444-4123', address: 'Corrientes 1847'
      )
      ClientRepository.new.save(client)
      client
    end

    let(:another_client) do
      another_client = described_class.new(
        username: 'otro_nombre', phone: '4444-4123', address: 'Corrientes 1847'
      )
      ClientRepository.new.save(another_client)
      another_client
    end

    let(:another_order_id) do
      another_order = Order.new(user_id: another_client.id, menu: 'menu_individual')
      another_order.update_status('entregado')
      OrderRepository.new.save(another_order)
      another_order.id
    end

    it 'should rate own order with 5' do
      another_client.rate_order(another_order_id, 5)
      expect(OrderRepository.new.find(another_order_id).rating).to be 5
    end

    it 'should raise order not found when rating an non existing order' do
      expect { another_client.rate_order(another_order_id + 10, 5) }.to raise_error(OrderNotFound)
    end

    it 'should raise no orders when client have not done an order and try to rate another' do
      expect { client.rate_order(another_order_id, 5) }.to raise_error(NoOrders)
    end
  end
end

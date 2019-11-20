require 'spec_helper'
require_relative '../../app/repositories/client_repository'
require_relative '../../app/models/order'
require_relative '../../app/exceptions/order_exception'

describe Client do
  describe 'model' do
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
    client = described_class.new(address: 'abc123')
    expect(client.valid?).to be false
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be true
  end

  it 'should not be valid with an address like "asd"' do
    client = described_class.new(address: 'asd')
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

    let(:order_id) do
      order = Order.new(user_id: client.id, menu: 'menu_individual')
      order.update_status('entregado')
      OrderRepository.new.save(order)
      order.id
    end

    it 'should rate own order with 5' do
      client.rate_order(order_id, 5)
      order = OrderRepository.new.find(order_id)
      expect(order.rating).to be 5
    end

    it 'should raise order not found' do
      expect { client.rate_order(1 + order_id, 5) }.to raise_error(OrderException)
    end
  end
end

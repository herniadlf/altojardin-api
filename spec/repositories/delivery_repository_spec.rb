require 'integration_spec_helper'
require_relative '../../app/models/delivery'
require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'
require_relative '../../app/repositories/client_repository'
require_relative '../../app/models/client'

describe DeliveryRepository do
  let(:repository) { described_class.new }

  let(:pepebicicleta_delivery) do
    pepebicicleta_delivery = Delivery.new(
      username: 'pepebicicleta'
    )
    pepebicicleta_delivery.available = false
    repository.save(pepebicicleta_delivery)
    pepebicicleta_delivery
  end

  let(:juanmotoneta_delivery) do
    juanmotoneta_delivery = Delivery.new(
      username: 'juanmotoneta'
    )
    juanmotoneta_delivery.available = false
    repository.save(juanmotoneta_delivery)
    juanmotoneta_delivery
  end

  let(:client) do
    client = Client.new(
      username: 'username',
      phone: '1233-1233',
      address: 'callefalsa 123'
    )
    ClientRepository.new.save(client)
    client
  end

  let(:order) do
    order = Order.new(
      user_id: client.id,
      menu: 'menu_individual',
      status: OrderStatus::IN_TRANSIT,
      assigned_to: pepebicicleta_delivery.id
    )
    OrderRepository.new.save(order)
    order
  end

  it 'should find delivery' do
    id = pepebicicleta_delivery.id
    pepebicicleta_delivery = repository.find(id)
    expect(pepebicicleta_delivery.user_id).to eq id
  end

  it 'should persist available delivery' do
    expect(repository.find(pepebicicleta_delivery.id).available).to eq false
    pepebicicleta_delivery.available = true
    repository.save(pepebicicleta_delivery)
    expect(repository.find(pepebicicleta_delivery.id).available).to eq true
  end

  context 'when deliveries have no orders' do
    it 'should find available deliveries' do
      pepebicicleta_delivery.available = true
      repository.save(pepebicicleta_delivery)
      pepebicicleta_delivery = repository.find_first_available_for_order(order)
      expect(pepebicicleta_delivery.nil?).to eq false
    end

    it 'should not find available deliveries' do
      pepebicicleta_delivery = repository.find_first_available_for_order(order)
      expect(pepebicicleta_delivery.nil?).to eq true
    end
  end

  context 'when deliveries have orders' do
    before(:each) do
      pepebicicleta_delivery.available = true
      juanmotoneta_delivery.available = true
      repository.save(pepebicicleta_delivery)
      repository.save(juanmotoneta_delivery)
    end

    it 'should find delivery with optimum space' do
      delivery = repository.find_first_available_for_order(order)
      expect(delivery.username).to eq 'pepebicicleta'
    end
  end
end

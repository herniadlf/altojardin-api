require 'integration_spec_helper'
require_relative '../../app/models/delivery'
require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'

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
      pepebicicleta_delivery = repository.find_first_available
      expect(pepebicicleta_delivery.nil?).to eq false
    end

    it 'should not find available deliveries' do
      pepebicicleta_delivery = repository.find_first_available
      expect(pepebicicleta_delivery.nil?).to eq true
    end
  end

  context 'when deliveries have orders' do
    let(:order) do
      order = Order.new(
        menu: 'menu_familiar',
        status: OrderStatus::DELIVERED,
        assigned_to: pepebicicleta_delivery.user_id
      )
      OrderRepository.new.save(order)
    end

    before(:each) do
      pepebicicleta_delivery.available = true
      juanmotoneta_delivery.available = true
      repository.save(pepebicicleta_delivery)
      repository.save(juanmotoneta_delivery)
    end

    it 'should find delivery with fewer deliveries' do
      delivery = repository.find_first_available
      expect(delivery.id).to eq juanmotoneta_delivery.id
    end
  end
end

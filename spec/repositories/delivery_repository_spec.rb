require 'integration_spec_helper'
require_relative '../../app/models/delivery'

describe DeliveryRepository do
  let(:repository) { described_class.new }

  let(:new_delivery) do
    new_delivery = Delivery.new(
      username: 'delivery'
    )
    repository.save(new_delivery)
    new_delivery
  end

  it 'should find delivery' do
    id = new_delivery.id
    delivery = repository.find(id)
    expect(delivery.user_id).to eq id
  end

  it 'should persist available delivery' do
    expect(repository.find(new_delivery.id).available).to eq true
    new_delivery.available = false
    repository.save(new_delivery)
    expect(repository.find(new_delivery.id).available).to eq false
  end
end

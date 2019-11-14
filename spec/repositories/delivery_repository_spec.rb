require 'integration_spec_helper'
require_relative '../../app/models/delivery'

describe DeliveryRepository do
  let(:repository) { described_class.new }

  let(:new_delivery) do
    new_delivery = Delivery.new(
      username: 'username'
    )
    repository.save(new_delivery)
    new_delivery
  end

  it 'should find delivery' do
    id = new_delivery.id
    delivery = repository.find(new_delivery.id)

    expect(delivery.user_id).to eq id
  end
end

require 'integration_spec_helper'
require_relative '../../app/models/order'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:order_owner) do
    user = User.new(telegram_id: '123', username: 'username')
    UserRepository.new.save(user)
    user
  end

  it 'should find created order' do
    order = Order.new(user_id: order_owner.id, menu_id: 1)
    repository.save(order)
    order = repository.first

    expect(order.nil?).to eq false
    expect(order.menu_id).to eq 1
  end

  it 'creation should fail if user is empty' do
    order = Order.new(menu_id: 1)
    repository.save(order)
    expect(order.valid?).to eq false
    expect(order.errors.messages[order.errors.messages.keys.first][0]).to eq 'empty_user'
  end
end

require 'integration_spec_helper'
require_relative '../../app/models/order'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:order_owner) do
    user = User.new(telegram_id: '123', username: 'username')
    UserRepository.new.save(user)
    user
  end

  let(:another_owner) do
    user = User.new(telegram_id: '456', username: 'johnlennon')
    UserRepository.new.save(user)
    user
  end

  it 'should find created order' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual')
    repository.save(order)
    order = repository.first

    expect(order.nil?).to eq false
    expect(order.menu).to eq 'menu_individual'
  end

  it 'creation should fail if user is empty' do
    order = Order.new(menu: 'menu_individual')
    repository.save(order)
    expect(order.valid?).to eq false
    expect(order.errors.messages[order.errors.messages.keys.first][0]).to eq 'empty_user'
  end

  it 'creation should fail with invalid menu' do
    order = Order.new(user_id: order_owner.id, menu: 'big_mac')
    repository.save(order)
    expect(order.valid?).to eq false
    expect(order.errors.messages[order.errors.messages.keys.first][0]).to eq 'invalid_menu'
  end

  it 'should find status received in created order' do
    repository.save(Order.new(user_id: order_owner.id, menu: 'menu_individual'))
    order = repository.first

    expect(order.status).to eq OrderStatus::RECEIVED
  end

  it 'should persist status changes' do
    repository.save(Order.new(user_id: order_owner.id, menu: 'menu_individual'))
    order = repository.first
    order.status = OrderStatus::IN_PROGRESS
    repository.save(order)

    expect(repository.first.status).to eq OrderStatus::IN_PROGRESS
  end

  it 'should not find status from another user' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual')
    repository.save(order)
    expect(repository.find_for_user(order.id, another_owner.id).nil?).to eq true
    expect(repository.find_for_user(order.id, order_owner.id).nil?).to eq false
  end
end

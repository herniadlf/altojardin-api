require 'integration_spec_helper'
require_relative '../../app/models/order'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:order_owner) do
    user = User.new(username: 'username')
    UserRepository.new.save(user)
    user
  end

  let(:another_owner) do
    user = User.new(username: 'johnlennon')
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
    expect(order.errors.messages[order.errors.messages.keys.first][0]).to eq 'user not exist'
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

  it 'should not find for username from unexistent order' do
    result = repository.find_for_username(1, another_owner.username)
    expect(result[:error]).to eq 'there are no orders'
  end

  it 'should not find for username from another user order' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual')
    repository.save(order)
    result = repository.find_for_username(order.id, another_owner.username)
    expect(result[:error]).to eq 'order not exist'
  end

  it 'should not find for username if it not exist' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual')
    repository.save(order)
    result = repository.find_for_username(order.id, 'notexistentusername')
    expect(result[:error]).to eq 'user not exist'
    expect(result[:order]).to eq nil
  end

  it 'should find order status for username' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual')
    repository.save(order)
    result = repository.find_for_username(order.id, order_owner.username)
    expect(result[:order].status_label[:key]).to eq 'recibido'
    expect(result[:order].status_label[:message]).to eq "Su pedido #{order.id} ha sido RECIBIDO"
  end
end

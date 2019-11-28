require 'integration_spec_helper'
require_relative '../../app/models/order'
require_relative '../../app/models/order_status'
require_relative '../../app/exceptions/order_exception'

describe OrderRepository do
  let(:repository) { described_class.new }

  let(:order_owner) do
    user = Client.new(username: 'username', phone: '4567-1233', address: 'calle falsa 123')
    ClientRepository.new.save(user)
    user
  end

  let(:another_owner) do
    user = Client.new(username: 'johnlennon', phone: '4567-1233', address: 'calle falsa 123')
    ClientRepository.new.save(user)
    user
  end

  let(:received_status) { OrderStatusReceived.new }

  let(:delivery) do
    delivery = Delivery.new(username: 'kitopizzas')
    DeliveryRepository.new.save(delivery)
    delivery
  end

  it 'should find created order' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual', status: received_status)
    repository.save(order)
    order = repository.find(order.id)

    expect(order.menu).to eq 'menu_individual'
    expect(order.weight).to eq 1
  end

  it 'creation should fail if user is empty' do
    expect do
      Order.new(menu: 'menu_individual')
    end.to raise_error(UnexistentUserException)
  end

  it 'creation should fail with invalid menu' do
    expect do
      Order.new(user_id: order_owner.id, menu: 'big_mac')
    end.to raise_error(InvalidMenuException)
  end

  it 'should find status received in created order' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual', status: received_status)
    repository.save(order)
    order = repository.find(order.id)

    expect(order.status.id).to eq OrderStatusReceived::RECEIVED_ID
  end

  it 'should persist status changes' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual', status: received_status)
    repository.save(order)
    order.status = OrderStatusInProgress.new
    repository.save(order)
    expect(repository.find(order.id).status.id).to eq OrderStatusInProgress::IN_PROGRESS_ID
  end

  it 'should not find for username from unexistent order' do
    expect do
      repository.find_for_username!(1, another_owner.username)
    end.to raise_error(OrderNotFound)
  end

  it 'should not find for username from another user order' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual', status: received_status)
    repository.save(order)
    expect do
      repository.find_for_username!(order.id, another_owner.username)
    end.to raise_error(OrderNotFound)
  end

  it 'should not find for username if it not exist' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual', status: received_status)
    repository.save(order)
    expect do
      repository.find_for_username!(order.id, 'notexistentusername')
    end.to raise_error(UnexistentUserException)
  end

  it 'should find order status for username' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual', status: received_status)
    repository.save(order)
    order = repository.find_for_username!(order.id, order_owner.username)
    expect(order.status_message[:key]).to eq 'recibido'
    expect(order.status_message[:message]).to eq "Su pedido #{order.id} ha sido RECIBIDO"
  end

  it 'should have a delivery assignment' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual',
                      status: received_status, assigned_to: delivery.id)
    order.update_status('en_entrega')
    result = repository.find(order.id)
    expect(result.assigned_to).to eq delivery.id
  end

  it 'should be rated' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual',
                      status: OrderStatusDelivered.new, assigned_to: delivery.id)
    order.rate(3)
    repository.save(order)
    expect(repository.find(order.id).rating).to eq 3
  end

  it 'should return false when user has no orders done' do
    expect(repository.find_if_client_has_done_orders(another_owner.username)).to eq false
  end

  it 'should return true when user has orders done' do
    order = Order.new(user_id: order_owner.id, menu: 'menu_individual',
                      status: received_status, assigned_to: delivery.id)
    repository.save(order)
    expect(repository.find_if_client_has_done_orders(order_owner.username)).to eq true
  end
end

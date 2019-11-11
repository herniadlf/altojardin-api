require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'

DeliveryApi::App.controllers :order do
  post '/', provides: :json do
    order = Order.new(params)
    result = OrderRepository.new.save(order)
    return { 'message': { 'order_number': order.id } }.to_json if result

    status 400
    {
      'error': 'error'
    }.to_json
  end
end

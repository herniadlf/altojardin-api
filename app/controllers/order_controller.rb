require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'

DeliveryApi::App.controllers :order do
  post '/', provides: :json do
    user = UserRepository.new.find_by_telegram_id(params['telegram_id'])
    params[:user_id] = user.id unless user.nil?
    order = Order.new(params)
    result = OrderRepository.new.save(order)
    return { 'message': { 'order_number': order.id } }.to_json if result

    status 400
    {
      'error': order.errors.messages[order.errors.messages.keys.first][0]
    }.to_json
  end
end

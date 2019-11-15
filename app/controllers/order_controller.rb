require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'

DeliveryApi::App.controllers :client do
  post '/:username/order', provides: :json do
    user = UserRepository.new.find_by_username(params['username'])
    params[:user_id] = user.id unless user.nil?
    params[:menu] = params['order']
    order = Order.new(params)
    result = OrderRepository.new.save(order)
    return { 'order_id': order.id }.to_json if result

    status 400
    {
      'error': order.errors.messages[order.errors.messages.keys.first][0]
    }.to_json
  end

  get '/:username/order/:order_id', provides: :json do
    order_id = params[:order_id]
    username = params[:username]
    result = OrderRepository.new.find_for_username(order_id, username)
    order = result[:order]
    error = result[:error]
    return { 'order_status': order.status_label }.to_json if error.nil?

    status 400
    { 'error': error }.to_json
  end
end

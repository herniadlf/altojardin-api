require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'

DeliveryApi::App.controllers :client do
  post '/:username/order', provides: :json do
    result = UserRepository.new.find_by_username(params['username'])
    user = result[:user]
    error = result[:error]
    params[:user_id] = user.id if error.nil?
    params[:menu] = params['order']
    order = Order.new(params)
    result = OrderRepository.new.save(order)
    return { 'order_id': order.id }.to_json if result

    key = order.errors.messages[order.errors.messages.keys.first][0]
    status 400
    {
      'error': key,
      'message': Messages.new.get_message(key)
    }.to_json
  end

  get '/:username/order/:order_id', provides: :json do
    order_id = params[:order_id]
    username = params[:username]
    result = OrderRepository.new.find_for_username(order_id, username)
    order = result[:order]
    error = result[:error]
    if error.nil?
      return {
        'order_status': order.status_label[:key],
        'message': order.status_label[:message]
      }.to_json
    end

    status 400
    {
      'error': error,
      'message': Messages.new.get_message(error)
    }.to_json
  end
end

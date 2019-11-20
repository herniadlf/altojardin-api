require_relative '../../app/models/order'
require_relative '../../app/repositories/order_repository'

DeliveryApi::App.controllers do
  post 'client/:username/order', provides: :json do
    auth = Security.new(request.env['HTTP_API_KEY']).authorize
    unless auth
      status 403
      key = Messages::INVALID_API_KEY
      return { 'error': key, 'message': Messages.new.get_message(key) }.to_json
    end
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

  get 'client/:username/order/:order_id', provides: :json do
    auth = Security.new(request.env['HTTP_API_KEY']).authorize
    unless auth
      status 403
      key = Messages::INVALID_API_KEY
      return { 'error': key, 'message': Messages.new.get_message(key) }.to_json
    end
    order_id = params[:order_id]
    username = params[:username]
    result = OrderRepository.new.find_for_username(order_id, username)
    order = result[:order]
    error = result[:error]
    if error.nil?
      return {
        'order_status': order.status_label[:key],
        'assigned_to': order.assigned_to_username,
        'message': order.status_label[:message]
      }.to_json
    end

    status 400
    {
      'error': error,
      'message': Messages.new.get_message(error)
    }.to_json
  end

  put 'order/:order_id/status', provides: :json do
    auth = Security.new(request.env['HTTP_API_KEY']).authorize
    unless auth
      status 403
      key = Messages::INVALID_API_KEY
      return { 'error': key, 'message': Messages.new.get_message(key) }.to_json
    end
    order_id = params[:order_id]
    new_status = params[:status]
    order = OrderRepository.new.find(order_id)
    if order.nil?
      status 400
      error = Messages::ORDER_NOT_EXIST_KEY
      return { error: error, message: Messages.new.get_message(error) }.to_json
    end
    order.update_status(new_status)
  end
end

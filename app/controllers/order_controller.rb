require_relative '../models/order'
require_relative '../repositories/order_repository'
require_relative 'utils'

DeliveryApi::App.controllers do
  post 'client/:username/order', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    client = ClientRepository.new.find_by_username!(params['username'])

    params[:user_id] = client.id
    params[:menu] = params['order']
    params[:status] = OrderStatusUtils.initial_status

    order = Order.new(params)
    OrderRepository.new.save(order)
    { 'order_id': order.id }.to_json
  rescue UserException, OrderException => e
    error_response(e.key, 400)
  rescue SecurityException => e
    error_response(e.key, 403)
  end

  get 'client/:username/order/:order_id', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize

    order_id = params[:order_id]
    username = params[:username]
    order = OrderRepository.new.find_for_username!(order_id, username)
    {
      'order_status': order.status_message[:key],
      'assigned_to': order.assigned_to_username,
      'message': order.status_message[:message]
    }.to_json
  rescue UserException, OrderException => e
    error_response(e.key, 400)
  rescue SecurityException => e
    error_response(e.key, 403)
  end

  put 'order/:order_id/status', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    order_id = params[:order_id]
    new_status = params[:status]
    order = OrderRepository.new.find!(order_id)
    order.update_status(new_status)
  rescue OrderException => e
    error_response(e.key, 400)
  rescue SecurityException => e
    error_response(e.key, 403)
  end
end

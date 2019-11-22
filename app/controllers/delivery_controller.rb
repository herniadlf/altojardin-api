require_relative '../models/client'
require_relative '../repositories/delivery_repository'
require_relative 'utils'

DeliveryApi::App.controllers :delivery do
  post '/', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    username = params[:username]
    user = UserRepository.new.find_by_username(username)[:user]
    unless user.nil?
      status 400
      key = Messages::ALREADY_REGISTERED
      return { 'error': key, 'message': Messages.new.get_message(key) }.to_json
    end
    delivery = Delivery.new(params)
    return { 'delivery_id': delivery.id }.to_json if DeliveryRepository.new.save(delivery)

    key = delivery.errors.messages[delivery.errors.messages.keys.first][0]
    status 400
    {
      'error': key,
      'message': Messages.new.get_message(key)
    }.to_json
  rescue SecurityException => e
    error_response(e.key, 403)
  end
end

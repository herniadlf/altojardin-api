require_relative '../models/client'
require_relative '../repositories/delivery_repository'
require_relative 'utils'

DeliveryApi::App.controllers :delivery do
  post '/', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    UserRepository.new.check_unexistent!(params[:username])

    delivery = Delivery.new(params)
    return { 'delivery_id': delivery.id }.to_json if DeliveryRepository.new.save(delivery)

    key = delivery.errors.messages[delivery.errors.messages.keys.first][0]
    status 400
    {
      'error': key,
      'message': Messages.new.get_message(key)
    }.to_json
  rescue UserAlreadyRegisteredException => e
    error_response(e.key, 400)
  rescue SecurityException => e
    error_response(e.key, 403)
  end
end

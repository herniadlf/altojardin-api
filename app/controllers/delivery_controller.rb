require_relative '../../app/models/client'
require_relative '../../app/repositories/delivery_repository'

DeliveryApi::App.controllers :delivery do
  post '/', provides: :json do
    delivery = Delivery.new(params)
    return { 'delivery_id': delivery.id }.to_json if DeliveryRepository.new.save(delivery)

    key = delivery.errors.messages[delivery.errors.messages.keys.first][0]
    status 400
    {
      'error': key,
      'message': Messages.new.get_message(key)
    }.to_json
  end
end

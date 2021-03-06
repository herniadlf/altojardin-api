require_relative '../models/client'
require_relative '../repositories/delivery_repository'
require_relative 'utils'

DeliveryApi::App.controllers :delivery do
  post '/', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    UserRepository.new.check_unexistent!(params[:username])

    delivery = Delivery.new(params)
    DeliveryRepository.new.save(delivery)
    { 'delivery_id': delivery.id }.to_json
  rescue SecurityException => e
    error_response(e.key, 403)
  rescue UserException => e
    error_response(e.key, 400)
  end
end

require_relative '../models/client'
require_relative '../repositories/client_repository'
require_relative '../messages/messages'
require_relative '../exceptions/user_exception'
require_relative '../security/security'
require_relative 'utils'

DeliveryApi::App.controllers :client do
  post '/', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    UserRepository.new.check_unexistent!(params[:username])

    client = Client.new(params)
    ClientRepository.new.save(client)
    { 'client_id': client.id }.to_json
  rescue SecurityException => e
    error_response(e.key, 403)
  rescue UserException => e
    error_response(e.key, 400)
  end

  get '/:username', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    user = UserRepository.new.find_by_username!(params[:username])
    { 'client_id': user.id }.to_json
  rescue UnexistentUserException => e
    error_response(e.key, 404)
  rescue SecurityException => e
    error_response(e.key, 403)
  end

  post '/:username/order/:order_id/rate', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    client = ClientRepository.new.find_by_username!(params[:username])

    client.rate_order(params[:order_id], params[:rating])
    { 'rating': params[:rating] }.to_json
  rescue UserException => e
    error_response(e.key, 404)
  rescue OrderException => e
    error_response(e.key, 400)
  rescue SecurityException => e
    error_response(e.key, 403)
  end
end

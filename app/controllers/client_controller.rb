require_relative '../models/client'
require_relative '../repositories/client_repository'
require_relative '../messages/messages'
require_relative '../security/security'
require_relative '../exceptions/user_exception'
require_relative 'utils'

DeliveryApi::App.controllers :client do
  post '/', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    UserRepository.new.check_unexistent!(params[:username])

    client = Client.new(params)
    return { 'client_id': client.id }.to_json if ClientRepository.new.save(client)

    error_response(client.errors.messages[client.errors.messages.keys.first][0], 400)
  rescue UserAlreadyRegisteredException => e
    error_response(e.key, 400)
  rescue SecurityException => e
    error_response(e.key, 403)
  end

  get '/:username', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    result = UserRepository.new.find_by_username(params[:username])
    return { 'client_id': result[:user].id }.to_json if result[:error].nil?

    error_response(result[:error], 404)
  rescue SecurityException => e
    error_response(e.key, 403)
  end

  post '/:username/order/:order_id/rate', provides: :json do
    Security.new(request.env['HTTP_API_KEY']).authorize
    result = ClientRepository.new.find_by_username(params[:username])

    return error_response(result[:error], 404) unless result[:error].nil?

    begin
      result[:client].rate_order(params[:order_id], params[:rating])
    rescue ApiException => e
      return error_response(e.key, 400)
    end

    {
      'rating': params[:rating]
    }.to_json
  rescue SecurityException => e
    error_response(e.key, 403)
  end
end

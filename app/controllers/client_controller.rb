require_relative '../../app/models/client'
require_relative '../../app/repositories/client_repository'
require_relative '../../app/messages/messages'

def error_response(key, status_code)
  status status_code
  {
    'error': key,
    'message': Messages.new.get_message(key)
  }.to_json
end

DeliveryApi::App.controllers :client do
  post '/', provides: :json do
    user = UserRepository.new.find_by_username(params[:username])[:user]
    return error_response(Messages::ALREADY_REGISTERED, 400) unless user.nil?

    client = Client.new(params)
    return { 'client_id': client.id }.to_json if ClientRepository.new.save(client)

    error_response(client.errors.messages[client.errors.messages.keys.first][0], 400)
  end

  get '/:username', provides: :json do
    result = UserRepository.new.find_by_username(params[:username])
    return { 'client_id': result[:user].id }.to_json if result[:error].nil?

    error_response(result[:error], 404)
  end

  post '/:username/order/:order_id/rate', provides: :json do
    result = ClientRepository.new.find_by_username(params[:username])

    return error_response(result[:error], 404) unless result[:error].nil?

    begin
      result[:client].rate_order(params[:order_id], params[:rating])
    rescue OrderException => e
      return error_response(e.key, 400)
    end

    {
      'rating': params[:rating]
    }.to_json
  end
end

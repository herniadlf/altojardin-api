require_relative '../../app/models/client'
require_relative '../../app/repositories/client_repository'
require_relative '../../app/messages/messages'

DeliveryApi::App.controllers :client do
  post '/', provides: :json do
    username = params[:username]
    user = UserRepository.new.find_by_username(username)[:user]
    unless user.nil?
      status 400
      key = Messages::ALREADY_REGISTERED
      return { 'error': key, 'message': Messages.new.get_message(key) }.to_json
    end
    client = Client.new(params)
    return { 'client_id': client.id }.to_json if ClientRepository.new.save(client)

    key = client.errors.messages[client.errors.messages.keys.first][0]
    status 400
    {
      'error': key,
      'message': Messages.new.get_message(key)
    }.to_json
  end

  get '/:username', provides: :json do
    username = params[:username]
    result = UserRepository.new.find_by_username username
    error = result[:error]
    user = result[:user]
    return { 'client_id': user.id }.to_json if error.nil?

    status 404
    {
      'error': error,
      'message': Messages.new.get_message(error)
    }.to_json
  end

  post '/:username/order/:order_id/rate', provides: :json do
    {
      'rating': 5
    }.to_json
  end
end

require_relative '../../app/models/client'
require_relative '../../app/repositories/client_repository'

DeliveryApi::App.controllers :client do
  post '/', provides: :json do
    client = Client.new(params)
    return { 'client_id': client.id }.to_json if ClientRepository.new.save(client)

    status 400
    {
      'error': client.errors.messages[client.errors.messages.keys.first][0]
    }.to_json
  end

  get '/', provides: :json do
    telegram_id = params[:telegram_id]
    client = ClientRepository.new.find_by_telegram_id telegram_id
    return { 'client_id': client.user_id }.to_json unless client.nil?

    status 404
    { 'error': 'Cliente no encontrado' }.to_json
  end
end

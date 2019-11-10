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
end

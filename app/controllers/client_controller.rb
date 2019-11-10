require_relative '../../app/models/client'
require_relative '../../app/repositories/client_repository'

DeliveryApi::App.controllers :client do
  post '/', provides: :json do
    client = Client.new(params)
    ClientRepository.new.save(client)
    { 'client_id': client.id }.to_json
  end
end

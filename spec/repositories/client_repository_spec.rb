require 'integration_spec_helper'
require_relative '../../app/models/client'

describe ClientRepository do
  let(:repository) { described_class.new }

  let(:new_client) do
    new_client = Client.new(
      telegram_id: '123',
      username: 'username',
      phone: '1233-1233',
      address: 'callefalsa 123'
    )
    repository.save(new_client)
    new_client
  end

  it 'should find user with telegram id 123' do
    client = repository.find_by_telegram_id(new_client.telegram_id)

    expect(client.telegram_id).to eq '123'
    expect(client.username).to eq 'username'
    expect(client.phone).to eq '1233-1233'
  end
end

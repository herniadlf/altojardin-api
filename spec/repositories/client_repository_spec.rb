require 'integration_spec_helper'
require_relative '../../app/models/client'

describe ClientRepository do
  let(:repository) { described_class.new }

  let(:new_client) do
    new_client = Client.new(
      username: 'username',
      phone: '1233-1233',
      address: 'callefalsa 123'
    )
    repository.save(new_client)
    new_client
  end

  it 'should find user with username' do
    client = repository.find_by_username!(new_client.username)
    expect(client.phone).to eq '1233-1233'
    expect(client.address).to eq 'callefalsa 123'
  end

  it 'should not find user with invalid username' do
    username = 'nameuser'
    expect do
      repository.find_by_username!(username)
    end.to raise_error UnexistentUserException
  end
end

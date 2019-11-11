require 'integration_spec_helper'
require_relative '../../app/models/user'

describe UserRepository do
  let(:repository) { described_class.new }

  let(:new_user) do
    user = User.new(telegram_id: '123', username: 'username')
    repository.save(user)
    user
  end

  it 'should find user with telegram id 123' do
    user = repository.find_by_telegram_id(new_user.telegram_id)

    expect(user.telegram_id).to eq '123'
    expect(user.username).to eq 'username'
  end

  it 'should fail when user has no telegram id' do
    user = User.new(username: 'username')
    repository.save(user)
    expect(user.valid?).to eq false
  end
end

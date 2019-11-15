require 'integration_spec_helper'
require_relative '../../app/models/user'

describe UserRepository do
  let(:repository) { described_class.new }

  let(:new_user) do
    user = User.new(username: 'username')
    repository.save(user)
    user
  end

  it 'should find user by username' do
    result = repository.find_by_username(new_user.username)
    user = result[:user]
    expect(user.username).to eq 'username'
  end

  it 'should not find user with unexistent username' do
    result = repository.find_by_username('nameuser')
    expect(result[:user].nil?).to eq true
    expect(result[:error]).to eq Messages::USER_NOT_EXIST_KEY
  end
end

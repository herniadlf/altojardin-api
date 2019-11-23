require 'integration_spec_helper'
require_relative '../../app/models/user'
require_relative '../../app/exceptions/user_exception'

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

  it 'should throw exception on registered user' do
    username = new_user.username
    expect { repository.check_unexistent!(username) }.to raise_error UserAlreadyRegisteredException
  end
end

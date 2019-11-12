require 'spec_helper'

describe Client do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:telegram_id) }
    it { is_expected.to respond_to(:username) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:address) }
    it { is_expected.to respond_to(:user_id) }
  end

  it 'should not be valid with an invalid phone' do
    client = described_class.new(username: 'Carlos', phone: 'abcd-4123', telegram_id: '')
    expect(client.valid?).to be false
    match = client.errors.messages[:phone].any? { |error| error == 'invalid_phone' }
    expect(match).to be true
  end

  it 'should not be valid with an address like "abc123"' do
    client = described_class.new(address: 'abc123')
    expect(client.valid?).to be false
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be true
  end

  it 'should not be valid with an address like "asd"' do
    client = described_class.new(address: 'asd')
    expect(client.valid?).to be false
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be true
  end

  it 'should be valid with an address like "Corrientes 1847"' do
    client = described_class.new(telegram_id: '123456', username: 'Carlos',
                                 phone: '4444-4123', address: 'Corrientes 1847')
    expect(client.valid?).to be true
    match = client.errors.messages[:address].any? { |error| error == 'invalid_address' }
    expect(match).to be false
  end
end

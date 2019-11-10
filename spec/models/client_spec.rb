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
    client = described_class.new(username: 'asda', phone: 'abcd-4123', telegram_id: '')
    expect(client.valid?).to be false
    match = client.errors.messages[:phone].any? { |error| error == 'invalid_phone' }
    expect(match).to be true
  end
end

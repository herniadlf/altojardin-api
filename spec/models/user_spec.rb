require 'spec_helper'

describe User do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:telegram_id) }
    it { is_expected.to respond_to(:username) }

    it 'should not be valid with an invalid name' do
      user = described_class.new(username: '#!?', telegram_id: '')
      expect(user.valid?).to be false
      match = user.errors.messages[:username].any? { |error| error == 'invalid_username' }
      expect(match).to be true
    end
  end
end
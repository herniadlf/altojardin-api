require 'spec_helper'

describe User do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:username) }

    it 'should not be valid with an invalid name' do
      user = described_class.new(username: '#!?')
      expect(user.valid?).to be false
      match = user.errors.messages[:username].any? { |error| error == 'invalid_username' }
      expect(match).to be true
    end

    it 'should not be valid with a short name' do
      user = described_class.new(username: 'pepe')
      expect(user.valid?).to be false
      match = user.errors.messages[:username].any? { |error| error == 'invalid_username' }
      expect(match).to be true
    end

    it 'should not be valid with a long name' do
      user = described_class.new(username: 'elseniordelosanillos')
      expect(user.valid?).to be false
      match = user.errors.messages[:username].any? { |error| error == 'invalid_username' }
      expect(match).to be true
    end
  end
end

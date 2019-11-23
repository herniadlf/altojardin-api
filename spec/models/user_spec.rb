require 'spec_helper'

describe User do
  describe described_class.new(username: 'Carlos') do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:username) }
  end

  describe 'validations' do
    it 'should not be valid with an invalid name' do
      expect do
        described_class.new(username: '#!?')
      end.to raise_error InvalidUsernameException
    end

    it 'should not be valid with a short name' do
      expect do
        described_class.new(username: 'pepe')
      end.to raise_error InvalidUsernameException
    end

    it 'should not be valid with a long name' do
      expect do
        described_class.new(username: 'elseniordelosanillos')
      end.to raise_error InvalidUsernameException
    end
  end
end

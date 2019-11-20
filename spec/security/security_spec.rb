require_relative '../../app/security/security'

describe Security do
  let(:some_key) { 'some_key' }

  describe 'model' do
    let(:security) { described_class.new(some_key) }

    it 'should respond to request_api_key' do
      expect(security.request_api_key).to eq some_key
    end
  end
end

require_relative '../../app/security/security'

describe Security do
  let(:some_key) { 'some_key' }
  let(:another_key) { 'another_key' }

  describe 'model' do
    let(:security) { described_class.new(some_key) }

    it 'should respond to request_api_key' do
      expect(security.request_api_key).to eq some_key
    end
  end

  describe 'authorization' do
    let(:security) { described_class.new(some_key) }

    it 'should authorize a valid request_api_key' do
      ENV['API_KEY'] = some_key
      security.authorize
    end

    it 'should not authorize a invalid request_api_key' do
      ENV['API_KEY'] = another_key
      expect { security.authorize }.to raise_error SecurityException
    end

    it 'should authorize if env has no api_key' do
      ENV['API_KEY'] = nil
      security.authorize
    end

    it 'should not authorize if request_api_key is empty' do
      ENV['API_KEY'] = some_key
      security = described_class.new(nil)
      expect { security.authorize }.to raise_error SecurityException
    end
  end
end

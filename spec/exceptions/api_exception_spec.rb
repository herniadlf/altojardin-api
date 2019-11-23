require_relative '../../app/exceptions/api_exception'

describe ApiException.new('key') do
  describe 'model' do
    it { is_expected.to respond_to(:key) }
  end
end

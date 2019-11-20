require_relative '../../app/exceptions/order_exception'

describe OrderException.new('key') do
  describe 'model' do
    it { is_expected.to respond_to(:key) }
  end
end

require 'spec_helper'

describe Delivery do
  describe described_class.new(username: 'Carlos') do
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:available) }
  end
end

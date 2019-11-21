require 'spec_helper'

describe Delivery do
  describe 'model' do
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:available) }
  end
end

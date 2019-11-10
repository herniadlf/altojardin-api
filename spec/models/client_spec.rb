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
end

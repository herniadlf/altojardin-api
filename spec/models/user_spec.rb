require 'spec_helper'

describe User do
  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:telegram_id) }
    it { is_expected.to respond_to(:username) }
  end
end

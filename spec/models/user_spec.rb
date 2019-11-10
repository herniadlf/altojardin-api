require 'spec_helper'

describe User do
  describe 'model' do
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:telegram_id) }
  end
end

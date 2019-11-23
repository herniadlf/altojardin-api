require 'spec_helper'

describe Weather do
  describe described_class.new(id: 1, date: '2019-6-6', rain: false) do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:rain) }
  end
end

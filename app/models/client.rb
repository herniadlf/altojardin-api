require_relative '../../app/models/user'

class Client < User
  attr_accessor :address, :phone, :user_id

  VALID_PHONE_REGEX = /[0-9]+-[0-9]+/i
  VALID_ADDRESS_REGEX = /([a-z]+)( [a-z]+)? ([0-9]+)/i

  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX,
                                              message: 'invalid_phone' }

  validates :address, presence: true, format: { with: VALID_ADDRESS_REGEX,
                                                message: 'invalid_address' }

  def initialize(data = {})
    super data
    @address = data[:address]
    @phone = data[:phone]
    @user_id = data[:user_id]
  end
end

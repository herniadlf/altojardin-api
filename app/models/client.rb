require_relative '../../app/models/user'

class Client < User
  attr_accessor :address, :phone, :user_id

  VALID_PHONE_REGEX = /[0-5]+-[0-5]+/i

  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX,
                                              message: 'invalid_phone' }

  def initialize(data = {})
    super data
    @address = data[:address]
    @phone = data[:phone]
    @user_id = data[:user_id]
  end
end

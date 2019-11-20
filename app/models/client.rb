require_relative '../../app/models/user'
require_relative '../../app/messages/messages'
require_relative '../../app/repositories/order_repository'

class Client < User
  attr_accessor :address, :phone, :user_id

  VALID_PHONE_REGEX = /[0-9]+-[0-9]+/i
  VALID_ADDRESS_REGEX = /([a-z]+)( [a-z]+)? ([0-9]+)/i

  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX,
                                              message: Messages::INVALID_PHONE_KEY }

  validates :address, presence: true, format: { with: VALID_ADDRESS_REGEX,
                                                message: Messages::INVALID_ADDRESS_KEY }

  def initialize(data = {})
    super data
    @address = data[:address]
    @phone = data[:phone]
    @user_id = data[:user_id]
  end

  def rate_order(order_id, rating)
    order = OrderRepository.new.find(order_id)
    raise OrderNotFound if order.nil?

    order.rate(rating)
    OrderRepository.new.save(order)
  end
end

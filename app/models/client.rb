require_relative 'user'
require_relative '../messages/messages'
require_relative '../repositories/order_repository'
require_relative '../exceptions/order_exception'

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
    o_repository = OrderRepository.new
    raise NoOrders unless o_repository.find_if_client_has_done_orders(username)

    result = o_repository.find_for_user(order_id, self)
    raise OrderNotFound if result[:error]

    order = result[:order]
    order.rate(rating)
    OrderRepository.new.save(order)
  end
end

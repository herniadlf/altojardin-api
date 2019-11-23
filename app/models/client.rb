require_relative 'user'
require_relative '../messages/messages'
require_relative '../repositories/order_repository'
require_relative '../exceptions/order_exception'
require_relative '../exceptions/client_exception'

class Client < User
  attr_accessor :address, :phone, :user_id

  def initialize(data = {})
    super data
    @address = data[:address]
    @phone = data[:phone]
    @user_id = data[:user_id]
  end

  def rate_order(order_id, rating)
    o_repository = OrderRepository.new
    raise NoOrders unless o_repository.find_if_client_has_done_orders(username)

    order = o_repository.find_for_user!(order_id, self)
    order.rate(rating)
    OrderRepository.new.save(order)
  end

  private

  def validate_data(data)
    super
    validate_phone(data[:phone])
    validate_address(data[:address])
  end

  VALID_PHONE_REGEX = /[0-9]+-[0-9]+/i
  def validate_phone(phone)
    invalid = phone.nil? || phone !~ VALID_PHONE_REGEX
    raise InvalidPhoneException if invalid
  end

  VALID_ADDRESS_REGEX = /([a-z]+)( [a-z]+)? ([0-9]+)/i
  def validate_address(address)
    invalid = address.nil? || address !~ VALID_ADDRESS_REGEX
    raise InvalidAddressException if invalid
  end
end

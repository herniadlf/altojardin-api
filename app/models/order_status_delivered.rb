require_relative 'order_status'
require_relative '../repositories/order_repository'

class OrderStatusDelivered < OrderStatus
  DELIVERED_ID = 4
  DELIVERED_KEY = 'entregado'.freeze
  DELIVERED_LABEL = 'esta ENTREGADO'.freeze

  def initialize
    @id = DELIVERED_ID
    @key = DELIVERED_KEY
    @label = DELIVERED_LABEL
  end
end

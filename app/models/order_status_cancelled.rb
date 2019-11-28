require_relative 'order_status'

class OrderStatusCancelled < OrderStatus
  CANCELLED_ID = 5
  CANCELLED_KEY = 'cancelado'.freeze
  CANCELLED_LABEL = 'ha sido CANCELADO'.freeze

  def initialize
    @id = CANCELLED_ID
    @key = CANCELLED_KEY
    @label = CANCELLED_LABEL
  end
end

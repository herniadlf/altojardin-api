require_relative 'order_status'
require_relative 'order_status_in_transit'
require_relative 'order_status_delivered'

class OrderStatusCancelled < OrderStatus
  CANCELLED_ID = 5
  CANCELLED_KEY = 'cancelado'.freeze
  CANCELLED_LABEL = 'ha sido CANCELADO'.freeze
  INVALID_PREVIOUS = [OrderStatusInTransit::IN_TRANSIT_ID,
                      OrderStatusDelivered::DELIVERED_ID].freeze

  def initialize
    @id = CANCELLED_ID
    @key = CANCELLED_KEY
    @label = CANCELLED_LABEL
  end

  def validate_previous(previous_status)
    raise CannotCancelOrderException if INVALID_PREVIOUS.include? previous_status.id
  end

  def update(order)
    validate_previous(order.status)
    super
  end
end

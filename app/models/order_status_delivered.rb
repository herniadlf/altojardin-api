require_relative 'order_status'
require_relative '../repositories/order_repository'

class OrderStatusDelivered < OrderStatus
  def update
    @order.status = @status
    OrderRepository.new.save(@order)
  end
end

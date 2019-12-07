class OrderStatus
  attr_reader :id, :key, :label
  def initialize; end

  def change_order_to(order, new_status)
    new_status.update(order)
  end

  def validate_previous(previous_status); end

  def update(order)
    validate_previous(order.status)
    order.status = self
    OrderRepository.new.save(order)
  end
end

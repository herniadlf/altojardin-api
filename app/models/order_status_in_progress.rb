class OrderStatusInProgress < OrderStatus
  def update
    @order.status = @status
    OrderRepository.new.save(@order)
  end
end

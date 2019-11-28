class OrderStatusInTransit < OrderStatus
  def update
    delivery = DeliveryRepository.new.find_first_available_for_order(@order)
    if delivery.nil?
      @order.status = OrderStatusUtils::WAITING
    else
      @order.status = @status
      @order.assigned_to = delivery.id
      DeliveryRepository.new.save(delivery)
    end
    OrderRepository.new.save(@order)
  end
end

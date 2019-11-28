class OrderStatusInTransit < OrderStatus
  IN_TRANSIT_ID = 2
  IN_TRANSIT_KEY = 'en_entrega'.freeze
  IN_TRANSIT_LABEL = 'esta EN ENTREGA'.freeze

  def initialize
    @id = IN_TRANSIT_ID
    @key = IN_TRANSIT_KEY
    @label = IN_TRANSIT_LABEL
  end

  def update(order)
    delivery = DeliveryRepository.new.find_first_available_for_order(order)
    if delivery.nil?
      order.status = OrderStatusWaiting.new
    else
      order.status = self
      order.assigned_to = delivery.id
      DeliveryRepository.new.save(delivery)
    end
    OrderRepository.new.save(order)
  end
end

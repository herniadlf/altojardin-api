module OrderStatusObserver
  class OrderStatusObserver
    def initialize; end

    def load_data(data)
      @order = data[:order]
      @status = data[:status]
    end
  end

  class InProgress < OrderStatusObserver
    def update
      @order.status = @status
      OrderRepository.new.save(@order)
    end
  end

  class InTransit < OrderStatusObserver
    def update
      delivery = DeliveryRepository.new.find_first_available_for_order(@order)
      if delivery.nil?
        @order.status = OrderStatus::WAITING
      else
        @order.status = @status
        @order.assigned_to = delivery.id
        DeliveryRepository.new.save(delivery)
      end
      OrderRepository.new.save(@order)
    end
  end

  class Delivered < OrderStatusObserver
    def update
      @order.status = @status
      OrderRepository.new.save(@order)
    end
  end
end
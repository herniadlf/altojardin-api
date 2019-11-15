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
      @order.status = @status
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

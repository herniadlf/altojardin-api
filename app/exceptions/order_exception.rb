require_relative '../messages/messages'
require_relative 'api_exception'

class OrderNotFound < ApiException
  def initialize
    super(Messages::ORDER_NOT_EXIST_KEY)
  end
end

class OrderNotDelivered < ApiException
  def initialize
    super(Messages::ORDER_NOT_DELIVERED)
  end
end

class NoOrders < ApiException
  def initialize
    super(Messages::NO_ORDERS_KEY)
  end
end

class RatingRangeNotValid < ApiException
  def initialize
    super(Messages::INVALID_RATING)
  end
end

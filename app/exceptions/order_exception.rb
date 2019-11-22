require_relative '../messages/messages'
require_relative 'api_exception'

class OrderException < ApiException
  def initialize(msg)
    super(msg)
  end
end

class InvalidMenuException < OrderException
  def initialize
    super(Messages::INVALID_MENU)
  end
end

class InvalidStatusException < OrderException
  def initialize
    super(Messages::INVALID_STATUS)
  end
end

class OrderNotFound < OrderException
  def initialize
    super(Messages::ORDER_NOT_EXIST_KEY)
  end
end

class OrderNotDelivered < OrderException
  def initialize
    super(Messages::ORDER_NOT_DELIVERED)
  end
end

class NoOrders < OrderException
  def initialize
    super(Messages::NO_ORDERS_KEY)
  end
end

class RatingRangeNotValid < OrderException
  def initialize
    super(Messages::INVALID_RATING)
  end
end

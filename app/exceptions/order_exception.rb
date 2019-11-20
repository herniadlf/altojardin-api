require_relative '../../app/messages/messages'

class OrderException < RuntimeError
  attr_reader :key
  def initialize(key)
    @key = key
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

class OrderNotFromUser < OrderException
  def initialize
    super(Messages::NO_ORDERS_KEY)
  end
end

class RatingRangeNotValid < OrderException
  def initialize
    super(Messages::INVALID_RATING)
  end
end

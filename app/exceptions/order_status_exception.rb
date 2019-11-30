class CannotCancelOrderException < OrderException
  def initialize
    super(Messages::CANNOT_CANCEL_ORDER)
  end
end

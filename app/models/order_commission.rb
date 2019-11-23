class OrderCommission
  attr_accessor :order_price, :rating, :rainy
  def initialize(data = {})
    @order_price = data[:order_price]
    @rating = data[:rating]
    @rainy = data[:rainy]
  end

  def calculate
    @order_price * DEFAULT_COMMISSION
  end

  DEFAULT_COMMISSION = 0.05
end

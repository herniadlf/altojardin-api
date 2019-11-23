class OrderCommission
  attr_accessor :order_price, :rating, :rainy
  def initialize(data = {})
    @order_price = data[:order_price]
    @rating = data[:rating]
    @rainy = data[:rainy]
  end

  def calculate
    5.0
  end
end

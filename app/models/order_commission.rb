class OrderCommission
  attr_accessor :order_price, :rating, :rainy
  def initialize(data = {})
    @order_price = data[:order_price]
    @rating = data[:rating]
    @rainy = data[:rainy]
  end

  def calculate
    rating_commission = RATING_COMMISSION[@rating]
    (@order_price * rating_commission).round(2)
  end

  BAD_RATING_COMMISSION = 0.03
  DEFAULT_COMMISSION = 0.05
  BONUS_RATING_COMMISSION = 0.07
  RATING_COMMISSION = {
    1 => BAD_RATING_COMMISSION,
    2 => DEFAULT_COMMISSION,
    3 => DEFAULT_COMMISSION,
    4 => DEFAULT_COMMISSION,
    5 => BONUS_RATING_COMMISSION
  }.freeze
end

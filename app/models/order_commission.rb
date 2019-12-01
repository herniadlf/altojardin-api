class OrderCommission
  attr_accessor :order_price, :rating
  def initialize(data = {})
    @order_price = data[:order_price]
    @rating = data[:rating]
    @status = data[:status]
  end

  def calculate
    if @status != OrderStatusDelivered::DELIVERED_ID
      raise CommissionException, 'order_not_delivered'
    end

    rating_commission = RATING_COMMISSION[@rating]
    if WeatherRepository.new.current_weather.rain
      rating_commission += BONUS_RAINING_RATING_COMMISSION
    end
    (@order_price * rating_commission).round(2)
  end

  BAD_RATING_COMMISSION = 0.03
  DEFAULT_COMMISSION = 0.05
  BONUS_RATING_COMMISSION = 0.07
  BONUS_RAINING_RATING_COMMISSION = 0.01
  RATING_COMMISSION = {
    1 => BAD_RATING_COMMISSION,
    2 => DEFAULT_COMMISSION,
    3 => DEFAULT_COMMISSION,
    4 => DEFAULT_COMMISSION,
    5 => BONUS_RATING_COMMISSION
  }.freeze
end

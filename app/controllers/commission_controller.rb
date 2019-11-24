require_relative '../repositories/order_repository'
require_relative '../models/order_commission'

DeliveryApi::App.controllers do
  get '/commission/:order_id', provides: :json do
    order = OrderRepository.new.find! params[:order_id]
    data = { order_price: order.price, rating: order.rating }
    commission = OrderCommission.new(data).calculate
    { commission_amount: commission }.to_json
  end
end

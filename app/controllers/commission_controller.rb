require_relative '../repositories/order_repository'
require_relative '../models/order_commission'
require_relative '../../app/exceptions/commission_exception'

DeliveryApi::App.controllers do
  get '/commission/:order_id', provides: :json do
    order = OrderRepository.new.find! params[:order_id]
    data = { order_price: order.price, rating: order.rating, status: order.status.id }
    puts(data.inspect)
    commission = OrderCommission.new(data).calculate
    return { commission_amount: commission }.to_json
  rescue CommissionException => e
    error_response(e.key, 400)
  end
end

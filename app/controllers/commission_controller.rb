DeliveryApi::App.controllers do
  get '/commission/:order_id', provides: :json do
    status 200
  end
end

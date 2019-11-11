require 'faraday'
require 'json'

BASE_URL = ENV['BASE_URL'] || 'http://localhost:3000'
API_KEY = ENV['API_KEY'] || 'zaraza'

CLIENT_BASE_URL = BASE_URL + '/client'
REGISTER_DELIVERY_URL = BASE_URL + '/delivery'
SUBMIT_ORDER_URL = BASE_URL + '/order'
QUERY_ORDER_URL = BASE_URL + '/order'
QUERY_COMISION_URL = BASE_URL + '/commission'

def query_commission_url(order_id)
  BASE_URL + "/commission/#{order_id}"
end

def cancel_order_url(order_id)
  BASE_URL + "/order/#{order_id}/cancel"
end

def header
  { 'Content-Type' => 'application/json', 'api-key' => API_KEY }
end

def submit_order_url(username)
  CLIENT_BASE_URL + "/#{username}/order"
end

def query_order_status_url(username, order_id)
  CLIENT_BASE_URL + "/#{username}/order/#{order_id}"
end

def change_order_status_url(order_id)
  BASE_URL + "/order/#{order_id}/status"
end

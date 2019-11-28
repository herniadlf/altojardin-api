require_relative 'order_status'

class OrderStatusWaiting < OrderStatus
  WAITING_ID = 3
  WAITING_KEY = 'en_espera'.freeze
  WAITING_LABEL = 'esta EN ESPERA'.freeze

  def initialize
    @id = WAITING_ID
    @key = WAITING_KEY
    @label = WAITING_LABEL
  end
end

require_relative 'order_status'

class OrderStatusReceived < OrderStatus
  RECEIVED_ID = 0
  RECEIVED_KEY = 'recibido'.freeze
  RECEIVED_LABEL = 'ha sido RECIBIDO'.freeze

  def initialize
    @id = RECEIVED_ID
    @key = RECEIVED_KEY
    @label = RECEIVED_LABEL
  end
end

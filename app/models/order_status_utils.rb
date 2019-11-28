module OrderStatusUtils
  RECEIVED = 0
  IN_PROGRESS = 1
  IN_TRANSIT = 2
  WAITING = 3
  DELIVERED = 4
  CANCELLED = 5
  TO_STATUS_MAP = {
    'recibido' => RECEIVED,
    'en_preparacion' => IN_PROGRESS,
    'en_entrega' => IN_TRANSIT,
    'en_espera' => WAITING,
    'entregado' => DELIVERED,
    'cancelado' => CANCELLED
  }.freeze
  FROM_STATUS_MAP = {
    RECEIVED => { key: 'recibido', label: 'ha sido RECIBIDO' },
    IN_PROGRESS => { key: 'en_preparacion', label: 'esta EN PREPARACION' },
    IN_TRANSIT => { key: 'en_entrega', label: 'esta EN ENTREGA' },
    WAITING => { key: 'en_espera', label: 'esta EN ESPERA' },
    DELIVERED => { key: 'entregado', label: 'esta ENTREGADO' },
    CANCELLED => { key: 'cancelado', label: 'ha sido CANCELADO' }
  }.freeze
  IMPL_MAP = {
    IN_PROGRESS => -> { OrderStatusInProgress.new },
    IN_TRANSIT => -> { OrderStatusInTransit.new },
    DELIVERED => -> { OrderStatusDelivered.new }
  }.freeze

  def self.get_status(order, status)
    status = TO_STATUS_MAP[status]
    data = { order: order, status: status }
    implementation = IMPL_MAP[status].call
    implementation.load_data(data)
    implementation
  end
end

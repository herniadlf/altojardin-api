module OrderStatus
  RECEIVED = 0
  IN_PROGRESS = 1
  IN_TRANSIT = 2
  WAITING = 3
  DELIVERED = 4
  CANCELLED = 5
  LABELS = {
    RECEIVED => 'recibido',
    IN_PROGRESS => 'en_preparacion',
    IN_TRANSIT => 'en_entrega',
    WAITING => 'en_espera',
    DELIVERED => 'entregado',
    CANCELLED => 'cancelado'
  }.freeze
end

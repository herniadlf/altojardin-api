module OrderStatus
  RECEIVED = 0
  IN_PROGRESS = 1
  IN_TRANSIT = 2
  WAITING = 3
  DELIVERED = 4
  CANCELLED = 5
  STATUS_MAP = {
    RECEIVED => { key: 'recibido', label: 'ha sido RECIBIDO' },
    IN_PROGRESS => { key: 'en_preparacion', label: 'esta EN PREPARACION' },
    IN_TRANSIT => { key: 'en_entrega', label: 'esta EN ENTREGA' },
    WAITING => { key: 'en_espera', label: 'esta EN ESPERA' },
    DELIVERED => { key: 'entregado', label: 'esta ENTREGADO' },
    CANCELLED => { key: 'cancelado', label: 'ha sido CANCELADO' }
  }.freeze
end

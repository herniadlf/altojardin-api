module OrderStatusUtils
  FROM_KEY = {
    OrderStatusReceived::RECEIVED_KEY => -> { OrderStatusReceived.new },
    OrderStatusInProgress::IN_PROGRESS_KEY => -> { OrderStatusInProgress.new },
    OrderStatusInTransit::IN_TRANSIT_KEY => -> { OrderStatusInTransit.new },
    OrderStatusWaiting::WAITING_KEY => -> { OrderStatusWaiting.new },
    OrderStatusDelivered::DELIVERED_KEY => -> { OrderStatusDelivered.new },
    OrderStatusCancelled::CANCELLED_KEY => -> { OrderStatusCancelled.new }
  }.freeze
  FROM_ID = {
    OrderStatusReceived::RECEIVED_ID => -> { OrderStatusReceived.new },
    OrderStatusInProgress::IN_PROGRESS_ID => -> { OrderStatusInProgress.new },
    OrderStatusInTransit::IN_TRANSIT_ID => -> { OrderStatusInTransit.new },
    OrderStatusWaiting::WAITING_ID => -> { OrderStatusWaiting.new },
    OrderStatusDelivered::DELIVERED_ID => -> { OrderStatusDelivered.new },
    OrderStatusCancelled::CANCELLED_ID => -> { OrderStatusCancelled.new }
  }.freeze

  def self.from_label(status_label)
    status_impl = FROM_KEY[status_label]
    return status_impl.call unless status_impl.nil?

    nil
  end

  def self.from_id(status_id)
    status_impl = FROM_ID[status_id]
    return status_impl.call unless status_impl.nil?

    nil
  end

  def self.initial_status
    OrderStatusReceived.new
  end
end

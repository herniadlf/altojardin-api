class OrderStatusInProgress < OrderStatus
  IN_PROGRESS_ID = 1
  IN_PROGRESS_KEY = 'en_preparacion'.freeze
  IN_PROGRESS_LABEL = 'esta EN PREPARACION'.freeze

  def initialize
    @id = IN_PROGRESS_ID
    @key = IN_PROGRESS_KEY
    @label = IN_PROGRESS_LABEL
  end
end

class OrderStatus
  def initialize; end

  def load_data(data)
    @order = data[:order]
    @status = data[:status]
  end

  def update; end
end

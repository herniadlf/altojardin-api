class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_for_user(order_id, user)
    order = find(order_id)
    order unless order.nil? || order.user_id != user.id
  rescue StandardError
    nil
  end

  protected

  def changeset(order)
    {
      user_id: order.user_id,
      menu: order.menu,
      status: order.status
    }
  end
end

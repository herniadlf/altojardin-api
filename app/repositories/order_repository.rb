class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_for_user(order_id, user_id)
    order = find(order_id)
    order unless order.user_id != user_id
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

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  protected

  def changeset(order)
    {
      user_id: order.user_id,
      menu: order.menu
    }
  end
end

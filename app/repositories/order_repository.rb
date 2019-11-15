class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_for_username(order_id, username)
    user = UserRepository.new.find_by_username username
    return { 'error': 'user not exist' } if user.nil?

    order = find(order_id)
    return { 'order': order } unless order.nil? || order.user_id != user.id

    { 'error': 'order not exist' }
  rescue StandardError
    { 'error': 'there are no orders' }
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

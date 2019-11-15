class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_for_username(order_id, username)
    user = UserRepository.new.find_by_username username
    return { 'error': user[:error] } unless user[:error].nil?

    user = user[:user]
    order = find(order_id)
    return { 'order': order } unless order.nil? || order.user_id != user.id

    { 'error': Messages::ORDER_NOT_EXIST_KEY }
  rescue StandardError
    { 'error': Messages::NO_ORDERS_KEY }
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

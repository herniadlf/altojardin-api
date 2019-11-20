class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_for_username(order_id, username)
    user = UserRepository.new.find_by_username username
    return { 'error': user[:error] } unless user[:error].nil?

    find_for_user(order_id, user)
  end

  def find_for_user(order_id, user)
    user = user[:user]
    order = find(order_id)
    return { 'error': Messages::NO_ORDERS_KEY } if order.nil?

    return { 'error': Messages::ORDER_NOT_EXIST_KEY } if order.user_id != user.id

    { 'order': order }
  end

  def find(id)
    order = dataset.first(pk_column => id)
    return load_object order unless order.nil?

    order
  end

  protected

  def changeset(order)
    {
      user_id: order.user_id,
      menu: order.menu,
      status: order.status,
      assigned_to: order.assigned_to,
      rating: order.rating
    }
  end
end

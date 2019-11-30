require_relative '../../app/repositories/base_repository'

class OrderRepository < BaseRepository
  self.table_name = :orders
  self.model_class = 'Order'

  def find_for_username!(order_id, username)
    user = UserRepository.new.find_by_username! username
    find_for_user!(order_id, user)
  end

  def find_for_user!(order_id, user)
    order = find(order_id)
    raise OrderNotFound if order.nil?

    raise OrderNotFound if order.user_id != user.id

    order
  end

  def find_by_delivery_id(delivery_id)
    rows = dataset.where(assigned_to: delivery_id)
    load_collection(rows) unless rows.nil?
  end

  def find_by_client_username(username)
    client = ClientRepository.new.find_by_username!(username)
    rows = dataset.where(user_id: client.id)
    load_collection(rows) unless rows.nil?
  end

  def find_if_client_has_done_orders(username)
    DB['select * from orders
        inner join clients on clients.user_id = orders.user_id
        inner join users on clients.user_id = users.id
        where users.username = ?', username].count.positive?
  end

  def find(id)
    order = dataset.first(pk_column => id)
    return load_object order unless order.nil?

    order
  end

  def find!(id)
    order = find(id)
    raise OrderNotFound if order.nil?

    order
  end

  protected

  def load_object(a_record)
    status_id = a_record[:status]
    a_record[:status] = OrderStatusUtils.from_id(status_id) unless status_id.nil?
    super
  end

  def changeset(order)
    {
      user_id: order.user_id,
      menu: order.menu,
      status: order.status.id,
      assigned_to: order.assigned_to,
      rating: order.rating
    }
  end
end

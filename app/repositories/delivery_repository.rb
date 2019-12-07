require_relative '../models/delivery'

class DeliveryRepository < BaseRepository
  self.table_name = :deliveries
  self.model_class = 'Delivery'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  def find_first_available_for_order(order)
    possible_deliveries = load_collection(dataset.where(available: true)).select do |delivery|
      Delivery::CAPACITY - delivery.occupied_quantity >= order.weight
    end

    return nil if possible_deliveries.empty?

    select_delivery(possible_deliveries)
  end

  protected

  def changeset(user)
    {
      user_id: user.id,
      available: user.available
    }
  end

  def insert_changeset(a_record)
    changeset_with_timestamps(a_record)
  end

  def update_changeset(a_record)
    changeset_with_timestamps(a_record)
  end

  def changeset_with_timestamps(a_record)
    changeset(a_record)
  end

  def pk_column
    Sequel[self.class.table_name][:user_id]
  end

  def load_object(a_record)
    user = UserRepository.new.find(a_record[:user_id])
    a_record[:id] = user.id
    a_record[:username] = user.username
    orders = OrderRepository.new.find_by_delivery_id(user.id)
    a_record[:occupied_quantity] = calculate_orders_weight(orders)
    a_record[:orders_done_today] = calculate_orders_done_today(orders)
    super
  end

  def select_delivery(possible_deliveries)
    possible_deliveries = possible_deliveries.sort_by(&:occupied_quantity).reverse
    return possible_deliveries.first if possible_deliveries.count == 1

    if possible_deliveries[0].occupied_quantity != possible_deliveries[1].occupied_quantity
      return possible_deliveries.first
    end

    possible_deliveries.min_by(&:orders_done_today)
  end

  private

  def calculate_orders_weight(orders)
    orders_weight = orders.map do |order|
      order.status.id == OrderStatusInTransit::IN_TRANSIT_ID ? order.weight : 0
    end
    orders_weight.sum
  end

  def calculate_orders_done_today(orders)
    orders_done_today = orders.select do |order|
      order.status.id == OrderStatusDelivered::DELIVERED_ID && order.created_on == Date.today
    end
    orders_done_today.length
  end
end

require_relative '../models/delivery'

class DeliveryRepository < BaseRepository
  self.table_name = :deliveries
  self.model_class = 'Delivery'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  def find_first_available_for_order(order)
    possible_deliveries = deliveries_with_capacity(order.weight)

    return nil if possible_deliveries.empty?

    select_delivery(possible_deliveries.all)
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
    delivery = super
    user = UserRepository.new.find(delivery.user_id)
    delivery.id = user.id
    delivery.username = user.username
    delivery
  end

  def deliveries_with_capacity(needed_capacity)
    DB[" with deliveries_with_occupancy as(
      select deliveries.user_id,
             sum(case when orders.status = 2 then weight else 0 end) as occupied_quantity
      from deliveries
              left join orders on orders.assigned_to = deliveries.user_id
              left join menu_types on orders.menu = menu_types.menu
          where deliveries.available is True
      group by deliveries.user_id
      order by occupied_quantity desc, user_id desc)
      select user_id, occupied_quantity from deliveries_with_occupancy
      where(#{Delivery::CAPACITY} - occupied_quantity) >= #{needed_capacity}
      order by occupied_quantity desc, user_id asc"
    ]
  end

  def select_delivery(possible_deliveries)
    return find(possible_deliveries[0][:user_id]) if possible_deliveries.count == 1

    if possible_deliveries[0][:occupied_quantity] != possible_deliveries[1][:occupied_quantity]
      return find(possible_deliveries[0][:user_id])
    end

    find_delivery_with_fewest_shippings_in_the_day(possible_deliveries)
  end

  def find_delivery_with_fewest_shippings_in_the_day(deliveries)
    user_id = DB["
      select deliveries.user_id, count(distinct orders) as quantity
      from deliveries left join orders on orders.assigned_to = deliveries.user_id
      where deliveries.user_id in ?
      and orders.created_on = now()::date or orders.created_on is null
      group by deliveries.user_id
      order by quantity asc
      limit 1", deliveries.map { |user| user[:user_id] }
    ].map(:user_id)[0]

    find(user_id)
  end
end

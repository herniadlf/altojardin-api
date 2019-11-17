class DeliveryRepository < BaseRepository
  self.table_name = :deliveries
  self.model_class = 'Delivery'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  def find_first_available_for_menu(_menu)
    deliveries_order_quantity.each do |delivery|
      return find(delivery[:user_id])
    end
    nil
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

  def deliveries_order_quantity
    DB['
      select deliveries.user_id, sum(case when orders.status = 2 then weight else 0 end) as quantity
      from deliveries
              left join orders on orders.assigned_to = deliveries.user_id
              left join order_type on orders.menu = order_type.menu
          where deliveries.available is True
      group by deliveries.user_id
      order by quantity asc;'
    ]
  end
end

class DeliveryRepository < BaseRepository
  self.table_name = :deliveries
  self.model_class = 'Delivery'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  protected

  def changeset(user)
    {
      user_id: user.id
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
    delivery.username = user.username
    delivery
  end
end

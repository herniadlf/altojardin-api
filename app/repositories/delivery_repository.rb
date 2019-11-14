class DeliveryRepository < BaseRepository
  self.table_name = :clients
  self.model_class = 'Client'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  protected

  def changeset(client)
    {
      user_id: client.id
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
end

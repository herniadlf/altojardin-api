class ClientRepository < BaseRepository
  self.table_name = :clients
  self.model_class = 'Client'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  def find_by_telegram_id(telegram_id)
    user = UserRepository.new.find_by_telegram_id(telegram_id)
    find(user.id)
  end

  protected

  def changeset(client)
    {
      user_id: client.id,
      phone: client.phone,
      address: client.address
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

  def load_object(a_record)
    client = super
    user = UserRepository.new.find(client.user_id)
    client.telegram_id = user.telegram_id
    client.username = user.username
    client
  end

  def pk_column
    Sequel[self.class.table_name][:user_id]
  end
end

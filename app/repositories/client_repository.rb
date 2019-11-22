class ClientRepository < BaseRepository
  self.table_name = :clients
  self.model_class = 'Client'

  def save(a_record)
    UserRepository.new.save(a_record) && super(a_record)
  end

  def find_by_username!(username)
    user = UserRepository.new.find_by_username!(username)
    result = dataset.first(user_id: user.id)
    raise UnexistentUserException if result.nil?

    load_object(result)
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
    user = UserRepository.new.find(a_record[:user_id])
    a_record[:id] = user.id
    a_record[:username] = user.username
    super
  end

  def pk_column
    Sequel[self.class.table_name][:user_id]
  end
end

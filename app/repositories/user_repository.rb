class UserRepository < BaseRepository
  self.table_name = :users
  self.model_class = 'User'

  def find_by_telegram_id(telegram_id)
    row = dataset.first(telegram_id: telegram_id)
    load_object(row) unless row.nil?
  end

  def find_by_username(username)
    row = dataset.first(username: username)
    load_object(row) unless row.nil?
  end

  protected

  def changeset(user)
    {
      telegram_id: user.telegram_id,
      username: user.username
    }
  end
end

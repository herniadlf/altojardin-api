class UserRepository < BaseRepository
  self.table_name = :users
  self.model_class = 'User'

  def find_by_username(username)
    row = dataset.first(username: username)
    return { user: load_object(row) } unless row.nil?

    { 'error': Messages::USER_NOT_EXIST_KEY }
  end

  protected

  def changeset(user)
    {
      username: user.username
    }
  end
end

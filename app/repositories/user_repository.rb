class UserRepository < BaseRepository
  self.table_name = :users
  self.model_class = 'User'

  def find_by_username(username)
    row = dataset.first(username: username)
    return { user: load_object(row) } unless row.nil?

    { 'error': Messages::USER_NOT_EXIST_KEY }
  end

  def find_by_username!(username)
    result = find_by_username(username)
    raise UnexistentUserException unless result[:error].nil?

    result[:user]
  end

  def check_unexistent!(username)
    result = find_by_username(username)
    raise UserAlreadyRegisteredException unless result[:user].nil?
  end

  protected

  def changeset(user)
    {
      username: user.username
    }
  end
end

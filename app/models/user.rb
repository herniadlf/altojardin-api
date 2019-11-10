class User
  attr_reader :user_id, :telegram_id

  def intialize(data = {})
    @user_id = data[:user_id]
    @telegram_id = data[:telegram_id]
  end
end

require_relative '../../app/models/user'

class Delivery < User
  attr_accessor :user_id, :available

  def initialize(data = {})
    super data
    @user_id = data[:user_id]
    @available = data[:available]
  end
end

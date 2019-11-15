require_relative '../../app/models/user'

class Delivery < User
  attr_accessor :user_id

  def initialize(data = {})
    super data
    @user_id = data[:user_id]
  end
end

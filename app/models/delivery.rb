require_relative '../../app/models/user'

class Delivery < User
  attr_accessor :user_id, :available

  CAPACITY = 4

  def initialize(data = {})
    super data
    @user_id = data[:user_id]
    @available = data[:available].nil? ? true : data[:available]
  end
end
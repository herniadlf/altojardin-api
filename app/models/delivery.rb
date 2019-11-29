require_relative '../../app/models/user'

class Delivery < User
  attr_accessor :user_id, :available, :occupied_quantity

  CAPACITY = 4

  def initialize(data = {})
    super data
    @user_id = data[:user_id]
    @available = data[:available].nil? ? true : data[:available]
    @occupied_quantity = data[:occupied_quantity]
  end
end

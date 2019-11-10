require_relative '../../app/models/user'

class Client < User
  attr_accessor :address, :phone, :user_id

  def initialize(data = {})
    super data
    @address = data[:address]
    @phone = data[:phone]
    @user_id = data[:user_id]
  end
end

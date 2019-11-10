require_relative '../../app/models/user'

class Client < User
  attr_accessor :address, :phone
end

require_relative '../messages/messages'
require_relative 'user_exception'

class ClientNotExist < UserException
  def initialize
    super(Messages::USER_NOT_EXIST_KEY)
  end
end

class InvalidPhoneException < UserException
  def initialize
    super(Messages::INVALID_PHONE_KEY)
  end
end

class InvalidAddressException < UserException
  def initialize
    super(Messages::INVALID_ADDRESS_KEY)
  end
end

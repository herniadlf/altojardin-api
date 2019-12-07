require_relative '../messages/messages'
require_relative 'api_exception'

class UserException < ApiException
  def initialize(msg)
    super(msg)
  end
end

class UserAlreadyRegisteredException < UserException
  def initialize
    super(Messages::ALREADY_REGISTERED)
  end
end

class InvalidUsernameException < UserException
  def initialize
    super(Messages::INVALID_USERNAME_KEY)
  end
end

class UnexistentUserException < UserException
  def initialize
    super(Messages::USER_NOT_EXIST_KEY)
  end
end

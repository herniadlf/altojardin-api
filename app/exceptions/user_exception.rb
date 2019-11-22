require_relative '../messages/messages'

class UserAlreadyRegisteredException < ApiException
  def initialize
    super(Messages::ALREADY_REGISTERED)
  end
end

class InvalidUsernameException < ApiException
  def initialize
    super(Messages::INVALID_USERNAME_KEY)
  end
end

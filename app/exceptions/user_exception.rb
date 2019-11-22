require_relative '../messages/messages'

class UserAlreadyRegisteredException < ApiException
  def initialize
    super(Messages::ALREADY_REGISTERED)
  end
end

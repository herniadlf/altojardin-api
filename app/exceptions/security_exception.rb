require_relative '../messages/messages'

class SecurityException < ApiException
  def initialize
    super(Messages::INVALID_API_KEY)
  end
end

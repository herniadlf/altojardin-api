require_relative '../messages/messages'
require_relative 'api_exception'

class SecurityException < ApiException
  def initialize
    super(Messages::INVALID_API_KEY)
  end
end

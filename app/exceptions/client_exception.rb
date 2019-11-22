require_relative '../messages/messages'

class ClientException < RuntimeError
  attr_reader :key
  def initialize(key)
    @key = key
  end
end

class ClientNotExist < ClientException
  def initialize
    super(Messages::USER_NOT_EXIST_KEY)
  end
end

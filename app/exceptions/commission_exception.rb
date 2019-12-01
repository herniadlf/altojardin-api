require_relative 'api_exception'

class CommissionException < ApiException
  def initialize(msg)
    super(msg)
  end
end

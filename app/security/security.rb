class Security
  attr_accessor :request_api_key
  def initialize(request_api_key)
    @request_api_key = request_api_key
  end
end

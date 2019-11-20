class Security
  attr_accessor :request_api_key
  def initialize(request_api_key)
    @request_api_key = request_api_key
  end

  def authorize
    request_api_key == ENV['API_KEY']
  end
end

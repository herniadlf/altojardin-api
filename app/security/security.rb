class Security
  attr_accessor :request_api_key
  def initialize(request_api_key)
    @request_api_key = request_api_key
  end

  def authorize
    api_key = ENV['API_KEY']
    return @request_api_key == api_key unless api_key.nil?

    true
  end
end

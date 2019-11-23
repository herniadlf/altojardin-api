require_relative '../../app/exceptions/security_exception'

class Security
  attr_accessor :request_api_key
  def initialize(request_api_key)
    @request_api_key = request_api_key
  end

  def authorize
    api_key = ENV['API_KEY']
    auth = api_key.nil? || @request_api_key == api_key
    raise SecurityException unless auth
  end
end

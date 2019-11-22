class ApiException < RuntimeError
  attr_reader :key
  def initialize(key)
    @key = key
  end
end

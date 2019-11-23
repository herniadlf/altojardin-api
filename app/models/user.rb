require_relative '../../app/messages/messages'
require 'active_model'

class User
  include ActiveModel::Validations

  attr_accessor :id, :created_on, :updated_on, :username

  def initialize(data = {})
    validate_data data
    @id = data[:id]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
    @username = data[:username]
  end

  private

  VALID_REGEX = /\A[a-z0-9_]{5,19}\z/i

  def validate_data(data)
    validate_username(data[:username])
  end

  def validate_username(username)
    invalid = username.nil? || username !~ VALID_REGEX
    raise InvalidUsernameException if invalid
  end
end

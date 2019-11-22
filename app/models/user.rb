require_relative '../messages/messages'

class User
  include ActiveModel::Validations

  attr_accessor :id, :created_on, :updated_on, :username

  VALID_REGEX = /\A[a-z0-9_]{5,19}\z/i

  validates :username, presence: true, format: { with: VALID_REGEX,
                                                 message: 'invalid_username' }
  def initialize(data = {})
    @id = data[:id]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
    @username = data[:username]
  end
end

class User
  include ActiveModel::Validations

  attr_accessor :id, :telegram_id, :created_on, :updated_on, :username

  VALID_REGEX = /[a-z0-9_]{5,}/i

  validates :username, presence: true, format: { with: VALID_REGEX,
                                                 message: 'invalid_username' }
  def initialize(data = {})
    @id = data[:id]
    @telegram_id = data[:telegram_id]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
    @username = data[:username]
  end
end

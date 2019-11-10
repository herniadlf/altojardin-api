class User
  include ActiveModel::Validations

  attr_accessor :id, :telegram_id, :created_on, :updated_on

  def initialize(data = {})
    @id = data[:id]
    @telegram_id = data[:telegram_id]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
  end
end

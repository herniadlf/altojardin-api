class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu, :created_on, :updated_on

  validates :user_id, presence: { message: 'empty_user' }

  def initialize(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu = data[:menu]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
  end
end

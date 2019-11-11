class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu_id, :created_on, :updated_on

  def initialize(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu_id = data[:menu_id]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
  end
end

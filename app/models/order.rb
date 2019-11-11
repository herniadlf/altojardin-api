class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu_id, :created_on, :updated_on

  def initialize(_data = {}) end
end

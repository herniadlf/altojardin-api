require_relative 'order_status'

class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu, :created_on, :updated_on, :status

  validate :valid_menu
  validates :user_id, presence: { message: Messages::USER_NOT_EXIST_KEY }
  validates :status, inclusion: { in: OrderStatus::RECEIVED..OrderStatus::CANCELLED,
                                  message: Messages::INVALID_STATUS }

  def initialize(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu = data[:menu]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
    @status = data[:status].nil? ? OrderStatus::RECEIVED : data[:status]
  end

  def update_status(new_status)
    @status = new_status
    OrderRepository.new.save(self)
  end

  def status_label
    status = OrderStatus::STATUS_MAP[@status]
    key = status[:key]
    message = "Su pedido #{id} #{status[:label]}"
    { key: key, message: message }
  end

  private

  def valid_menu
    errors.add(:menu, Messages::INVALID_MENU) unless VALID_MENUS.include? @menu
  end

  VALID_MENUS = %w[menu_individual menu_parejas menu_familiar].freeze
end

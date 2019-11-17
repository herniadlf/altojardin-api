require_relative 'order_status'

class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu, :created_on, :updated_on, :status, :assigned_to

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
    @assigned_to = data[:assigned_to]
    @weight = data[:weight]
  end

  def weight
    @weight || (@weight = DB[:menu_types].first(menu: @menu)[:weight])
  end

  def update_status(new_status)
    OrderStatus.observer(self, new_status).update
  end

  def status_label
    status = OrderStatus::FROM_STATUS_MAP[@status]
    key = status[:key]
    message = "Su pedido #{id} #{status[:label]}"
    { key: key, message: message }
  end

  def assigned_to_username
    return nil if @assigned_to.nil?

    delivery = DeliveryRepository.new.find(@assigned_to)
    delivery.username
  end

  private

  def valid_menu
    errors.add(:menu, Messages::INVALID_MENU) unless VALID_MENUS.include? @menu
  end

  VALID_MENUS = %w[menu_individual menu_pareja menu_familiar].freeze
end

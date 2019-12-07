require_relative '../../app/exceptions/order_exception'
require_relative 'order_status_utils'

class Order
  include ActiveModel::Validations

  attr_reader :rating
  attr_accessor :id, :user_id, :menu, :created_on, :updated_on, :status, :assigned_to

  def initialize(data = {})
    validate_data data
    initialize_mandatories(data)
    initialize_nullables(data)
  end

  def weight
    @weight || (@weight = DB[:menu_types].first(menu: @menu)[:weight])
  end

  def price
    MENU_PRICES[@menu]
  end

  def rate(rating)
    raise OrderNotDelivered if @status.id != OrderStatusDelivered::DELIVERED_ID
    raise RatingRangeNotValid if (rating < 1) || (rating > 5)

    @rating = rating
  end

  def cancel
    update_status(OrderStatusCancelled::CANCELLED_KEY)
    Messages::SUCCESSFUL_CANCEL
  end

  def update_status(new_status_label)
    new_status = OrderStatusUtils.from_label(new_status_label)
    raise InvalidStatusException if new_status.nil?

    @status.change_order_to(self, new_status)
  end

  def status_message
    key = status.key
    message = "Su pedido #{id} #{status.label}"
    { key: key, message: message }
  end

  def assigned_to_username
    return nil if @assigned_to.nil?

    delivery = DeliveryRepository.new.find(@assigned_to)
    delivery.username
  end

  private

  MENU_PRICES = {
    'menu_individual' => 100.0,
    'menu_pareja' => 175.0,
    'menu_familiar' => 250 - 0
  }.freeze

  def initialize_mandatories(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu = data[:menu]
    @status = data[:status]
  end

  def initialize_nullables(data = {})
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
    @assigned_to = data[:assigned_to]
    @weight = data[:weight]
    @rating = data[:rating]
  end

  def validate_data(data)
    valid_menu(data[:menu])
    valid_user(data[:user_id])
    valid_status(data[:status])
  end

  def valid_menu(menu)
    invalid = menu.nil? || !VALID_MENUS.include?(menu)
    raise InvalidMenuException if invalid
  end

  def valid_user(user_id)
    raise UnexistentUserException if user_id.nil?
  end

  def valid_status(status)
    raise InvalidStatusException if status.nil?
  end

  VALID_MENUS = %w[menu_individual menu_pareja menu_familiar].freeze
end

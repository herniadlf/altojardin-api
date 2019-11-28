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
    raise OrderNotDelivered if @status != OrderStatusUtils::DELIVERED
    raise RatingRangeNotValid if (rating < 1) || (rating > 5)

    @rating = rating
  end

  def update_status(new_status)
    raise InvalidStatusException if OrderStatusUtils::TO_STATUS_MAP[new_status].nil?

    OrderStatusUtils.get_status(self, new_status).update
  end

  def status_label
    status = OrderStatusUtils::FROM_STATUS_MAP[@status]
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

  MENU_PRICES = {
    'menu_individual' => 100.0,
    'menu_pareja' => 175.0,
    'menu_familiar' => 250 - 0
  }.freeze

  def initialize_mandatories(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu = data[:menu]
    @status = data[:status].nil? ? OrderStatusUtils::RECEIVED : data[:status]
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
    valid = status.nil? || VALID_STATUS.include?(status)
    raise InvalidStatusException unless valid
  end

  VALID_MENUS = %w[menu_individual menu_pareja menu_familiar].freeze
  VALID_STATUS = OrderStatusUtils::RECEIVED..OrderStatusUtils::CANCELLED.freeze
end

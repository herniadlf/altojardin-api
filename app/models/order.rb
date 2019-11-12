require_relative 'order_status'

class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu, :created_on, :updated_on, :status

  validate :valid_menu
  validates :user_id, presence: { message: 'empty_user' }
  validates :status, inclusion: { in: OrderStatus::RECEIVED..OrderStatus::CANCELLED,
                                  message: 'invalid_status' }

  def initialize(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu = data[:menu]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
    @status = data[:status].nil? ? OrderStatus::RECEIVED : data[:status]
  end

  def status_label
    OrderStatus::LABELS[@status]
  end

  private

  def valid_menu
    errors.add(:base, 'invalid_menu') unless VALID_MENUS.include? @menu
  end

  VALID_MENUS = %w[menu_individual menu_parejas menu_familiar].freeze
end

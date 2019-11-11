class Order
  include ActiveModel::Validations

  attr_accessor :id, :user_id, :menu, :created_on, :updated_on

  validate :valid_menu
  validates :user_id, presence: { message: 'empty_user' }

  def initialize(data = {})
    @id = data[:id]
    @user_id = data[:user_id]
    @menu = data[:menu]
    @created_on = data[:created_on]
    @updated_on = data[:updated_on]
  end

  private

  def valid_menu
    errors.add(:base, 'invalid_menu') unless VALID_MENUS.include? @menu
  end

  VALID_MENUS = %w[menu_individual menu_pareja menu_familiar].freeze
end

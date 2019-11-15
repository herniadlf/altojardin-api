class Messages
  INVALID_PHONE_KEY = 'invalid_phone'.freeze
  INVALID_ADDRESS_KEY = 'invalid_address'.freeze
  INVALID_USERNAME_KEY = 'invalid_username'.freeze
  USER_NOT_EXIST_KEY = 'user not exist'.freeze
  ORDER_NOT_EXIST_KEY = 'order not exist'.freeze
  NO_ORDERS_KEY = 'there are no orders'.freeze
  INVALID_MENU = 'invalid_menu'.freeze
  INVALID_STATUS = 'invalid_status'.freeze

  def get_message(key)
    messages = {
      INVALID_PHONE_KEY => 'Telefono invalido',
      INVALID_ADDRESS_KEY => 'Direccion invalida',
      INVALID_USERNAME_KEY => 'Usuario invalido',
      USER_NOT_EXIST_KEY => 'El usuario no existe',
      ORDER_NOT_EXIST_KEY => 'El pedido no existe',
      NO_ORDERS_KEY => 'No existe el pedido',
      INVALID_MENU => 'Menú inválido',
      INVALID_STATUS => 'Estado inválido'
    }
    messages[key]
  end
end

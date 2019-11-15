class Messages
  INVALID_PHONE_KEY = 'invalid_phone'.freeze
  INVALID_ADDRESS_KEY = 'invalid_address'.freeze
  INVALID_USERNAME_KEY = 'invalid_username'.freeze

  def get_message(key)
    messages = {
      INVALID_PHONE_KEY => 'Telefono invalido',
      INVALID_ADDRESS_KEY => 'Direccion invalida',
      INVALID_USERNAME_KEY => 'Usuario invalido'
    }
    messages[key]
  end
end

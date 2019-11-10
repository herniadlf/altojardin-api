# language: es

Característica: Registracion de cliente

  Regla: nombre de usuario puede contener a-z, 0-9 y _

  @wip
  Escenario: RC1 - Registracion exitosa
    Dado el cliente "jperez"
    Cuando se registra con domicilio "Cucha Cucha 1234 1 Piso B" y telefono "4123-4123"
    Entonces obtiene un numero unico de cliente

  @wip
  Escenario: RC2 - registracion con nombre invalido
    Dado el cliente "#!?"
    Cuando se registra con domicilio "Plumas verdes" y telefono "4098-0997"
    Entonces obtiene un mensaje de error por nombre de usuario inválido

  @wip
  Escenario: RC3 - registracion con telefono invalida
    Dado el cliente "juanse"
    Cuando se registra con domicilio "Plumas verdes" y telefono "abcd-4123"
    Entonces obtiene un mensaje de error por número de teléfono inválido

  @wip
  Escenario: RC4 - registracion con domicilio invalida
    Dado el cliente "pedrosi"
    Cuando se registra con domicilio "a1" y telefono "4098-0997"
    Entonces obtiene un mensaje de error por domicilio inválido

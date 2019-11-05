Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure

DB =
  case Padrino.env
  when :development
    Sequel.connect('postgres://deliveryapi:deliveryapi@localhost/deliveryapi_development',
                   loggers: [logger])
  when :test
    test_db_host = ENV['DB_HOST'] || 'localhost'
    Sequel.connect("postgres://deliveryapi:deliveryapi@#{test_db_host}/deliveryapi_test",
                   loggers: [logger])
  when :staging
    Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
  when :production
    Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
  end

DB.loggers << Logger.new($stdout)

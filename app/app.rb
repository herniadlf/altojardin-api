module DeliveryApi
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    Padrino.configure :staging, :production do
      set :delivery_method, smtp: {
        authentication: :plain,
        enable_starttls_auto: true
      }
    end
  end
end

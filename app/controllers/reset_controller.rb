DeliveryApi::App.controllers do
  post '/reset' do
    if ENV['RACK_ENV'] == 'prod'
      status 401
      return 'ERROR'
    end
    OrderRepository.new.delete_all
    ClientRepository.new.delete_all
    DeliveryRepository.new.delete_all
    UserRepository.new.delete_all
    'Ok'
  end

  post '/weather' do
    if ENV['RACK_ENV'] == 'prod'
      status 401
      return 'ERROR'
    end
    status 200
  end
end

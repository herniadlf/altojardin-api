DeliveryApi::App.controllers do
  post '/reset' do
    if ENV['RACK_ENV'] == 'prod'
      status 401
      return 'ERROR'
    end
    ClientRepository.new.delete_all
    UserRepository.new.delete_all
    'Ok'
  end
end

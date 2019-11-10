DeliveryApi::App.controllers do
  post '/reset' do
    ClientRepository.new.delete_all
    UserRepository.new.delete_all
    'Ok'
  end
end

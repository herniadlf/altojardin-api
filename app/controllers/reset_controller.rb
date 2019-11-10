DeliveryApi::App.controllers do
  get '/reset' do
    User.destroy
    'Ok'
  end
end

require_relative '../../app/models/weather'

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
    WeatherRepository.new.delete_all
    'Ok'
  end

  post '/weather' do
    if ENV['RACK_ENV'] == 'prod'
      status 401
      return 'ERROR'
    end
    WeatherRepository.new.delete_all
    weather = Weather.new(date: Date.today.to_s, rain: params[:rain])
    WeatherRepository.new.save(weather)
    status 200
  end
end

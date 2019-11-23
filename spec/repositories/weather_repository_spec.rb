require 'integration_spec_helper'
require_relative '../../app/models/weather'
require_relative '../../app/repositories/weather_repository'
require 'webmock/rspec'

describe WeatherRepository do
  let(:repository) { described_class.new }

  let(:new_weather) do
    weather = Weather.new(date: '2017-06-06', rain: false)
    repository.save(weather)
    weather
  end

  it 'should find weather by date' do
    weather = repository.find_by_date(new_weather.date)
    expect(weather.date.to_s).to eq '2017-06-06'
  end

  it 'should go to service for today' do
    stub_api_send_weather
    weather = repository.current_weather
    expect(weather.date.to_s).to eq Date.today.to_s
    expect(weather.rain).to eq true
  end
end

def stub_api_send_weather
  ba_id = WeatherRepository.new.ba_id
  app_id = WeatherRepository.new.app_id
  url = "http://api.openweathermap.org/data/2.5/weather?id=#{ba_id}&APPID=#{app_id}"
  stub_request(:get, url)
    .to_return(status: 400, body: { weather: [{ mail: 'rain' }] }.to_json, headers: {})
end

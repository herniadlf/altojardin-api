require 'integration_spec_helper'
require_relative '../../app/models/weather'
require_relative '../../app/repositories/weather_repository'

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
end

class WeatherRepository < BaseRepository
  self.table_name = :weather
  self.model_class = 'Weather'

  BUENOS_AIRES_ID = 3_433_955
  APP_ID = ENV['WEATHER_APP_ID'] | ''
  RAIN_CODES = %w[Rain Thunderstorm Drizzle Snow Tornado Sand].freeze

  def find_by_date(date)
    row = dataset.first(date: date)
    load_object(row) unless row.nil?
  end

  def current_weather
    date = Date.today.to_s
    weather = find_by_date(date)
    return weather unless weather.nil?

    weather = Weather.new(date: date, rain: ask_service)
    save(weather)
    weather
  end

  def ask_service
    response = Faraday.get("http://api.openweathermap.org/data/2.5/weather?id=#{BUENOS_AIRES_ID}&APPID=#{APP_ID}")
    body = JSON.parse(response.body)
    puts('Body inspect')
    puts(body.inspect)
    RAIN_CODES.include? body['weather'][0]['main']
  end

  def ba_id
    BUENOS_AIRES_ID
  end

  def app_id
    APP_ID
  end

  def changeset(weather)
    {
      date: weather.date,
      rain: weather.rain
    }
  end

  protected

  def insert_changeset(a_record)
    changeset_with_timestamps(a_record)
  end

  def update_changeset(a_record)
    changeset_with_timestamps(a_record)
  end

  def changeset_with_timestamps(a_record)
    changeset(a_record)
  end
end

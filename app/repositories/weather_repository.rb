class WeatherRepository < BaseRepository
  self.table_name = :weather
  self.model_class = 'Weather'

  def find_by_date(date)
    row = dataset.first(date: date)
    return load_object(row) unless row.nil?

    nil
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

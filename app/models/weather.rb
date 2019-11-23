class Weather
  include ActiveModel::Validations

  attr_accessor :id, :date, :rain

  def initialize(data)
    @id = data[:id]
    @date = data[:date]
    @rain = data[:rain]
  end
end

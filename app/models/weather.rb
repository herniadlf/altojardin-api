class Weather
  attr_accessor :date, :rain

  def initialize(data)
    @date = data[:date]
    @rain = data[:rain]
  end
end

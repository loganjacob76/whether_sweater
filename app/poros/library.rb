class Library
  attr_reader :id,
              :destination
  
  def initialize(data, location)
    @id = nil
    @destination = location
    # binding.pry
  end

  def forecast
    weather = ForecastFacade.weather_for_city(@destination).current_weather
    {
      summary: weather[:conditions],
      temperature: "#{weather[:temperature].round(0)} F"
    }
  end
end
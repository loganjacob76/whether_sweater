class ForecastFacade
  class << self
    def weather_for_city(location)
      coordinates = LocationFacade.get_coordinates(location)
      data = ForecastService.city_weather(coordinates)
      Forecast.new(data)
    end
  end
end

class Trip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time

  def initialize(data, origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = data[:formattedTime].presence || 'impossible'
    @real_time = data[:time] if data[:time].present?
  end

  def weather_at_eta
    return {} if arrival_weather.nil?

    {
      temperature: arrival_weather[:temperature],
      conditions: arrival_weather[:conditions]
    }
  end

  private

  def arrival_weather
    return nil if @real_time.nil?

    forecast = ForecastFacade.weather_for_city(@end_city)
    travel = (Time.now + @real_time.seconds).beginning_of_hour.strftime('%T')

    if @real_time <= 86_400
      forecast.trip_weather[0..23].find do |hour|
        hour[:time] == travel
      end
    else
      forecast.trip_weather[24..48].find do |hour|
        hour[:time] == travel
      end
    end
  end
end

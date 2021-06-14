class Forecast
  attr_reader :current_weather,
              :id
  
  def initialize(data)
    @id = nil
    @current_weather = current_format(data[:current])
    @daily = data[:daily][0..4]
    @hourly = data[:hourly][0..7]
  end

  def daily_weather
    @daily.map do |day|
      daily_format(day)
    end
  end

  def hourly_weather
    @hourly.map do |hour|
      hourly_format(hour)
    end
  end

  def current_format(hash)
    {
      datetime: Time.at(hash[:dt]),
      sunrise: Time.at(hash[:sunrise]),
      sunset: Time.at(hash[:sunset]),
      temperature: hash[:temp],
      feels_like: hash[:feels_like],
      humidity: hash[:humidity],
      uvi: hash[:uvi],
      visibility: hash[:visibility],
      conditions: hash[:weather].first[:description],
      icon: hash[:weather].first[:icon]
    }
  end

  def daily_format(hash)
    {
      date: Time.at(hash[:dt]).strftime('%Y-%m-%d'),
      sunrise: Time.at(hash[:sunrise]),
      sunset: Time.at(hash[:sunset]),
      max_temp: hash[:temp][:max],
      min_temp: hash[:temp][:min],
      conditions: hash[:weather].first[:description],
      icon: hash[:weather].first[:icon]
    }
  end

  def hourly_format(hash)
    {
      time: Time.at(hash[:dt]).strftime('%T'),
      temperature: hash[:temp],
      conditions: hash[:weather].first[:description],
      icon: hash[:weather].first[:icon]
    }
  end
end
class ForecastService
  class << self
    def city_weather(location)
      resp = conn.get('/data/2.5/onecall') do |faraday|
        faraday.params['lat'] = location.lattitude
        faraday.params['lon'] = location.longitude
        faraday.params['units'] = 'imperial'
        faraday.params['exclude'] = 'minutely,alerts'
      end
      parse_json(resp)
    end

    private

    def conn
      Faraday.new(url: 'http://api.openweathermap.org') do |faraday|
        faraday.params['appid'] = ENV['openweather_key']
      end
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end

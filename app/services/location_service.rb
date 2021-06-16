class LocationService
  class << self
    def lat_and_long(location)
      resp = conn.get('/geocoding/v1/address') do |faraday|
        faraday.params['location'] = location
      end
      parse_json(resp)
    end

    def road_trip(origin, destination)
      resp = conn.get('/directions/v2/route') do |faraday|
        faraday.params['from'] = origin
        faraday.params['to'] = destination
      end
      parse_json(resp)
    end

    private

    def conn
      Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
        faraday.params['key'] = ENV['mapquest_key']
      end
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end

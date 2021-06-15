class LocationFacade
  class << self
    def get_coordinates(location)
      data = LocationService.lat_and_long(location)
      Location.new(data[:results].first[:locations].first[:displayLatLng])
    end
  end
end

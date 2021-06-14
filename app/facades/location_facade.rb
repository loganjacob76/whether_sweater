class LocationFacade
  class << self
    def get_coordinates(location)
      data = LocationService.lat_and_long(location)
      t = Location.new(data[:results].first[:locations].first[:displayLatLng])
      binding.pry
    end
  end
end
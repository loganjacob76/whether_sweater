class LocationFacade
  class << self
    def get_coordinates(location)
      data = LocationService.lat_and_long(location)
      Location.new(data[:results].first[:locations].first[:displayLatLng])
    end

    def new_trip(origin, destination)
      trip = LocationService.road_trip(origin, destination)
      Trip.new(trip[:route], origin, destination)
    end
  end
end

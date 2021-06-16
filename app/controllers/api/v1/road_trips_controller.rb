class API::V1::RoadTripsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only: :unauthorized

  def create
    trip = LocationFacade.new_trip(trip_info[:origin], trip_info[:destination])
    render json: RoadtripSerializer.new(trip)
  end

  def unauthorized
    render json: { errors: 'Unauthorized, please provide a valid key, origin city, and destination city', status: 401 }, status: :unauthorized
  end

  def authorize
    unauthorized unless current_user
  end

  def current_user
    return unauthorized if trip_info[:origin].nil? || trip_info[:destination].nil?
    
    User.find_by(api_key: trip_info[:api_key])
  end

  def trip_info
    JSON.parse(request.raw_post, symbolize_names: true)
  end
end

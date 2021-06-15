class API::V1::ForecastsController < ApplicationController
  def show
    if params[:location].present?
      forecast = ForecastFacade.weather_for_city(params[:location])
      render json: ForecastSerializer.new(forecast)
    else
      render json: { errors: 'No location found' }, status: :bad_request
    end
  end
end

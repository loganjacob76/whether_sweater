class API::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.weather_for_city(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end
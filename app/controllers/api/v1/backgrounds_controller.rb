class API::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      image = BackgroundsFacade.find_image(params[:location])
      render json: ImageSerializer.new(image)
    else
      render json: { errors: 'No location found' }, status: :bad_request
    end
  end
end
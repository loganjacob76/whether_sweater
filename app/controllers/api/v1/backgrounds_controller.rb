class API::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      image = BackgroundsFacade.find_image(params[:location])
      if image.is_a? Hash
        render json: image, status: :bad_request
      else
        render json: ImageSerializer.new(image)
      end
    else
      render json: { errors: 'No location found' }, status: :bad_request
    end
  end
end

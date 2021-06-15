class API::V1::UsersController < ApplicationController
  def create
    user_info = JSON.parse(request.raw_post, symbolize_names: true)
    user_info[:api_key] = SecureRandom.base58(24)
    user = User.new(user_info)
    if user.save
      render json: UsersSerializer.new(user)
    else
      render json: { errors: error_message(user.errors), status: 400 }, status: :bad_request
    end
  end
end

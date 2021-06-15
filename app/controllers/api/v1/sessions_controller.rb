class API::V1::SessionsController < ApplicationController
  def create
    user_info = JSON.parse(request.raw_post, symbolize_names: true)
    user = User.find_by(email: user_info[:email])
    if user.present? && user.authenticate(user_info[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: { errors: 'Email or password incorrect', status: 400 }, status: :bad_request
    end
  end
end

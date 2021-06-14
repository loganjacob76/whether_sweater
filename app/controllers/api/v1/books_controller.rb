class API::V1::BooksController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity].to_i

    if location.present? && quantity.present? && (quantity.is_a? Integer) && quantity > 0
      books = BookFacade.find_books(location, quantity)
      render json: BooksSerializer.new(books)
    elsif location.nil?
      render json: {errors: 'No location found'}, status: :bad_request
    else
      render json: {errors: 'Quantity must be an integer greater than 0'}, status: :bad_request
    end
  end
end
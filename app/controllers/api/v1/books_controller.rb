class API::V1::BooksController < ApplicationController
  def index
    quantity = params[:quantity].to_i
    if quantity.present? && quantity.class == Integer && quantity > 0
      books = BookFacade.find_books(params[:location], quantity)
      render json: BooksSerializer.new(books)
    else
      render json: {errors: 'Quantity must be an integer greater than 0'}, status: :bad_request
    end
  end
end
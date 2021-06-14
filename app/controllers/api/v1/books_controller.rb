class API::V1::BooksController < ApplicationController
  def index
    books = BookFacade.find_books(params[:location], params[:quantity])
    render json: BooksSerializer.new(books)
  end
end
class API::V1::LibraryController < ApplicationController
  def index
    LibraryFacade.find_books(params[:location], params[:quantity])
  end
end
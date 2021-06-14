class API::V1::LibrariesController < ApplicationController
  def index
    LibraryFacade.find_books(params[:location], params[:quantity])
  end
end
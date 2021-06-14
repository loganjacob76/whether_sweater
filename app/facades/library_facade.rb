class LibraryFacade
  class << self
    def find_books(location, quantity)
      data = LibraryService.find_books(location)
      data[:docs] = data[:docs][0..(quantity.to_i - 1)]
      
      Library.new(data)
    end
  end
end
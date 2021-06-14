class BookFacade
  class << self
    def find_books(location, quantity)
      data = BookService.find_books(location)
      data[:docs] = data[:docs][0..(quantity.to_i - 1)]
      
      Book.new(data, location)
    end
  end
end
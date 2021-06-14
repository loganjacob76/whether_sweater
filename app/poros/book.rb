class Book
  attr_reader :id,
              :destination,
              :total_books_found
  
  def initialize(data, location)
    @id = nil
    @destination = location
    @total_books_found = data[:num_found]
    @books = data[:docs]
  end

  def forecast
    weather = ForecastFacade.weather_for_city(@destination).current_weather
    {
      summary: weather[:conditions],
      temperature: "#{weather[:temperature].round(0)} F"
    }
  end
  
  def books
    @books.map do |book|
      format_book(book)
    end
  end

  def format_book(book)
    {
      isbn: book[:isbn],
      title: book[:title],
      publisher: book[:publisher]
    }
  end
end
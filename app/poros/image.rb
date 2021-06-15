class Image
  attr_reader :id

  def initialize(data, location)
    @id = nil
    @location = location
    @url = data[:urls][:raw]
    @photographer = data[:user][:name]
    @photographer_page = data[:user][:links][:html]
  end

  def image
    {
      location: @location,
      image_url: @url,
      credit: {
        source: 'unsplash.com',
        photographer: @photographer,
        photographer_page: @photographer_page
      }
    }
  end
end

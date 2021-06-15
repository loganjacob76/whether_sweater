class BackgroundsFacade
  class << self
    def find_image(location)
      images = BackgroundsService.background_image(location)
      return { errors: 'No location found' } if images[:results].empty?
      Image.new(images[:results].first, location)
    end
  end
end
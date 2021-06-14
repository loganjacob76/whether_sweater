class BackgroundsFacade
  class << self
    def find_image(location)
      images = BackgroundsService.background_image(location)
      Image.new(images[:results].first, location)
    end
  end
end
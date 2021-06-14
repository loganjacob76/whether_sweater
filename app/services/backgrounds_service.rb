class BackgroundsService
  class << self
    def background_image(location)
      resp = conn.get('search/photos') do |faraday|
        faraday.params['query'] = location
        faraday.params['per_page'] = 1
      end
      parse_json(resp)
    end
    
    private
    
    def conn
      Faraday.new(url: 'https://api.unsplash.com/') do |faraday|
        faraday.params['client_id'] = ENV['unsplash_key']
      end
    end

    def parse_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
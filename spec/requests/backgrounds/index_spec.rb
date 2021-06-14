require 'rails_helper'

RSpec.describe 'Background image' do
  describe 'request for a location' do
    it 'returns a json with an image link and info', :vcr do
      location = 'denver, co'
      get "/api/v1/backgrounds?location=#{location}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)
      
      image = JSON.parse(response.body, symbolize_names: true)

      expect(image).to be_a Hash
      expect(image).to have_key(:data)
      expect(image[:data]).to be_a Hash

      idata = image[:data]
      expect(idata).to have_key(:id)
      expect(idata[:id]).to eq(nil)
      expect(idata).to have_key(:type)
      expect(idata[:type]).to eq('image')
      expect(idata).to have_key(:attributes)
      expect(idata[:attributes]).to be_a Hash
      
      expect(idata[:attributes]).to have_key :image
      expect(idata[:attributes][:image]).to be_a Hash

      image_info = idata[:attributes][:image]
      expect(image_info).to have_key :location
      expect(image_info[:location]).to be_a String
      expect(image_info).to have_key :image_url
      expect(image_info[:image_url]).to be_a String
      expect(image_info).to have_key :credit
      expect(image_info[:credit]).to be_a Hash

      expect(image_info[:credit]).to have_key :source
      expect(image_info[:credit][:source]).to be_a String
      expect(image_info[:credit]).to have_key :photographer
      expect(image_info[:credit][:photographer]).to be_a String
      expect(image_info[:credit]).to have_key :photographer_page
      expect(image_info[:credit][:photographer_page]).to be_a String
    end
  end

  describe 'SAD Path' do
    it 'no location returns error', :vcr do
      get '/api/v1/backgrounds'

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('No location found')
    end
  end
end

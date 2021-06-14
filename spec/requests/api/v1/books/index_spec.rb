require 'rails_helper'

RSpec.describe 'Books by location' do
  describe 'search for books with the location param' do
    it 'returns forecast and book info', :vcr do
      location = 'denver, co'
      quantity = 5
      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)
      
      books = JSON.parse(response.body, symbolize_names: true)

      expect(books).to be_a Hash
      expect(books).to have_key(:data)
      expect(books[:data]).to be_a Hash

      bdata = books[:data]
      expect(bdata).to have_key(:id)
      expect(bdata[:id]).to eq(nil)
      expect(bdata).to have_key(:type)
      expect(bdata[:type]).to eq('books')
      expect(bdata).to have_key(:attributes)
      expect(bdata[:attributes]).to be_a Hash

      expect(bdata[:attributes]).to have_key(:destination)
      expect(bdata[:attributes][:destination]).to be_a String

      expect(bdata[:attributes]).to have_key(:forecast)
      expect(bdata[:attributes][:forecast]).to be_a Hash

      expect(bdata[:attributes]).to have_key(:total_books_found)
      expect(bdata[:attributes][:total_books_found]).to be_a Integer

      expect(bdata[:attributes]).to have_key(:books)
      expect(bdata[:attributes][:books]).to be_a Array

      forecast = bdata[:attributes][:forecast]
      all_books = bdata[:attributes][:books]
      
      expect(forecast).to have_key(:summary)
      expect(forecast[:summary]).to be_a String

      expect(forecast).to have_key(:temperature)
      expect(forecast[:temperature]).to be_a String

      expect(forecast).to_not have_key(:datetime)
      expect(forecast).to_not have_key(:sunrise)
      expect(forecast).to_not have_key(:sunset)
      expect(forecast).to_not have_key(:feels_like)
      expect(forecast).to_not have_key(:humidity)
      expect(forecast).to_not have_key(:uvi)
      expect(forecast).to_not have_key(:visibility)
      expect(forecast).to_not have_key(:icon)

      expect(all_books.count).to eq(5)
      all_books.each do |book|
        expect(book).to be_a Hash

        expect(book).to have_key :isbn
        expect(book[:isbn]).to be_a Array

        expect(book).to have_key :title
        expect(book[:title]).to be_a String

        expect(book).to have_key :publisher
        expect(book[:publisher]).to be_a Array
      end
    end
  end

  describe 'SAD PATH' do
    it 'non integer quantity returns error', :vcr do
      location = 'denver, co'
      quantity = 'fail'
      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('Quantity must be an integer greater than 0')
    end

    it 'quantity less than 0 returns error', :vcr do
      location = 'denver, co'
      quantity = 'fail'
      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('Quantity must be an integer greater than 0')
    end

    it 'no quantity returns error' do
      location = 'denver, co'
      get "/api/v1/book-search?location=#{location}"

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('Quantity must be an integer greater than 0')
    end
  end
end

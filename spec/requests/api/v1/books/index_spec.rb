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
      expect(bdata[:attributes]).to have_key(:Forecast)
      expect(bdata[:attributes][:Forecast]).to be_a Hash
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
end

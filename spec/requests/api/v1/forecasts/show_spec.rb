require 'rails_helper'

RSpec.describe 'City Forecast' do
  describe 'weather request for a chosen city' do
    it 'returns current weather, forecast for next 8 hours & next 5 days', :vcr do
      location = 'denver, co'
      get "/api/v1/forecast?location=#{location}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)
      
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a Hash
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a Hash

      fdata = forecast[:data]
      expect(fdata).to have_key(:id)
      expect(fdata[:id]).to eq(nil)
      expect(fdata).to have_key(:type)
      expect(fdata[:type]).to eq('forecast')
      expect(fdata).to have_key(:attributes)
      expect(fdata[:attributes]).to be_a Hash

      expect(fdata[:attributes]).to have_key(:current_weather)
      expect(fdata[:attributes][:current_weather]).to be_a Hash
      expect(fdata[:attributes]).to have_key(:daily_weather)
      expect(fdata[:attributes][:daily_weather]).to be_a Array
      expect(fdata[:attributes]).to have_key(:hourly_weather)
      expect(fdata[:attributes][:hourly_weather]).to be_a Array

      current = fdata[:attributes][:current_weather]
      daily = fdata[:attributes][:daily_weather]
      hourly = fdata[:attributes][:hourly_weather]
      
      expect(current).to have_key(:datetime)
      expect(current[:datetime]).to be_a String

      expect(current).to have_key(:sunrise)
      expect(current[:sunrise]).to be_a String

      expect(current).to have_key(:sunset)
      expect(current[:sunset]).to be_a String

      expect(current).to have_key(:temperature)
      expect(current[:temperature]).to be_a Float

      expect(current).to have_key(:feels_like)
      expect(current[:feels_like]).to be_a Float

      expect(current).to have_key(:humidity)
      expect(current[:humidity]).to be_a Integer

      expect(current).to have_key(:uvi)
      expect(current[:uvi]).to be_a Integer

      expect(current).to have_key(:visibility)
      expect(current[:visibility]).to be_a Integer

      expect(current).to have_key(:conditions)
      expect(current[:conditions]).to be_a String

      expect(current).to have_key(:icon)
      expect(current[:icon]).to be_a String


      expect(daily.count).to eq(5)
      daily.each do |day|
        expect(day).to have_key :date
        expect(day[:date]).to be_a String

        expect(day).to have_key :sunrise
        expect(day[:sunrise]).to be_a String

        expect(day).to have_key :sunset
        expect(day[:sunset]).to be_a String

        expect(day).to have_key :max_temp
        expect(day[:max_temp]).to be_a Float

        expect(day).to have_key :min_temp
        expect(day[:min_temp]).to be_a Float

        expect(day).to have_key :conditions
        expect(day[:conditions]).to be_a String

        expect(day).to have_key :icon
        expect(day[:icon]).to be_a String
      end

      expect(hourly.count).to eq(8)
      hourly.each do |hour|
        expect(hour).to have_key :time
        expect(hour[:time]).to be_a String
        
        expect(hour).to have_key :temperature
        expect(hour[:temperature]).to be_a Float
        
        expect(hour).to have_key :conditions
        expect(hour[:conditions]).to be_a String
        
        expect(hour).to have_key :icon
        expect(hour[:icon]).to be_a String
      end
    end
  end
  
  describe 'SAD Path' do
    it 'no location returns error', :vcr do
      get '/api/v1/forecast'

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('No location found')
    end
  end
end

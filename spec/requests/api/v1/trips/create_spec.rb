require 'rails_helper'

RSpec.describe 'trips controller' do
  before :each do
    User.create(email: 'test@test.edu', password: 'test', password_confirmation: 'test', api_key: 'sad5g6as5d4g165awe16')
  end

  describe 'you can create a new trip' do
    it 'returns start/end city, travel time, & destination weather @ time of arrival', :vcr do
      trip_info = {origin: 'Denver,Co', destination: 'Pueblo,CO', api_key: 'sad5g6as5d4g165awe16'}
      post "/api/v1/road_trip", params: trip_info.to_json
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)
      
      trip = JSON.parse(response.body, symbolize_names: true)

      expect(trip).to be_a Hash
      expect(trip).to have_key(:data)
      expect(trip[:data]).to be_a Hash

      tdata = trip[:data]
      expect(tdata).to have_key(:id)
      expect(tdata[:id]).to eq(nil)
      expect(tdata).to have_key(:type)
      expect(tdata[:type]).to eq('roadtrip')
      expect(tdata).to have_key(:attributes)
      expect(tdata[:attributes]).to be_a Hash

      expect(tdata[:attributes]).to have_key :start_city
      expect(tdata[:attributes][:start_city]).to be_a String
      expect(tdata[:attributes]).to have_key :end_city
      expect(tdata[:attributes][:end_city]).to be_a String
      expect(tdata[:attributes]).to have_key :travel_time
      expect(tdata[:attributes][:travel_time]).to be_a String
      expect(tdata[:attributes]).to have_key :weather_at_eta
      expect(tdata[:attributes][:weather_at_eta]).to be_a Hash

      weather = tdata[:attributes][:weather_at_eta]
      expect(weather).to have_key :temperature
      expect(weather[:temperature]).to be_a Float
      expect(weather).to have_key :conditions
      expect(weather[:conditions]).to be_a String
    end

    it 'New York to LA', :vcr do
      trip_info = {origin: 'New York,NY', destination: 'Los Angeles,CA', api_key: 'sad5g6as5d4g165awe16'}
      post "/api/v1/road_trip", params: trip_info.to_json
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)
      
      trip = JSON.parse(response.body, symbolize_names: true)

      expect(trip).to be_a Hash
      expect(trip).to have_key(:data)
      expect(trip[:data]).to be_a Hash

      tdata = trip[:data]
      expect(tdata).to have_key(:id)
      expect(tdata[:id]).to eq(nil)
      expect(tdata).to have_key(:type)
      expect(tdata[:type]).to eq('roadtrip')
      expect(tdata).to have_key(:attributes)
      expect(tdata[:attributes]).to be_a Hash

      expect(tdata[:attributes]).to have_key :start_city
      expect(tdata[:attributes][:start_city]).to be_a String
      expect(tdata[:attributes]).to have_key :end_city
      expect(tdata[:attributes][:end_city]).to be_a String
      expect(tdata[:attributes]).to have_key :travel_time
      expect(tdata[:attributes][:travel_time]).to be_a String
      expect(tdata[:attributes]).to have_key :weather_at_eta
      expect(tdata[:attributes][:weather_at_eta]).to be_a Hash

      weather = tdata[:attributes][:weather_at_eta]
      expect(weather).to have_key :temperature
      expect(weather[:temperature]).to be_a Float
      expect(weather).to have_key :conditions
      expect(weather[:conditions]).to be_a String
    end
  end

  describe 'SAD Path' do
    it 'Impossible destination returns impossible time & empty weather', :vcr do
      trip_info = {origin: 'Denver,Co', destination: 'London,UK', api_key: 'sad5g6as5d4g165awe16'}
      post "/api/v1/road_trip", params: trip_info.to_json

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)

      trip = JSON.parse(response.body, symbolize_names: true)

      expect(trip).to be_a Hash
      expect(trip).to have_key(:data)
      expect(trip[:data]).to be_a Hash

      tdata = trip[:data]
      expect(tdata).to have_key(:id)
      expect(tdata[:id]).to eq(nil)
      expect(tdata).to have_key(:type)
      expect(tdata[:type]).to eq('roadtrip')
      expect(tdata).to have_key(:attributes)
      expect(tdata[:attributes]).to be_a Hash

      expect(tdata[:attributes]).to have_key :start_city
      expect(tdata[:attributes][:start_city]).to be_a String
      expect(tdata[:attributes]).to have_key :end_city
      expect(tdata[:attributes][:end_city]).to be_a String
      expect(tdata[:attributes]).to have_key :travel_time
      expect(tdata[:attributes][:travel_time]).to eq('impossible')
      expect(tdata[:attributes]).to have_key :weather_at_eta
      expect(tdata[:attributes][:weather_at_eta]).to eq({})
    end

    it 'Bad api_key returns error', :vcr do
      trip_info = {origin: 'Denver,Co', destination: 'Pueblo,CO', api_key: 'sade16'}
      post "/api/v1/road_trip", params: trip_info.to_json

      expect(response.status).to eq(401)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('Unauthorized, please provide a valid key, origin city, and destination city')
      expect(error).to have_key :status
      expect(error[:status]).to eq(401)
    end

    it 'missing data fails', :vcr do
      trip_info = {origin: 'Denver,Co', api_key: 'sad5g6as5d4g165awe16'}
      post "/api/v1/road_trip", params: trip_info.to_json

      expect(response.status).to eq(401)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('Unauthorized, please provide a valid key, origin city, and destination city')
      expect(error).to have_key :status
      expect(error[:status]).to eq(401)
    end
  end
end
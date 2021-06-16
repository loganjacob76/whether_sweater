require 'rails_helper'

RSpec.describe Trip do
  describe 'HAPPY Path' do
    before :each do
      data = {:hasTollRoad=>false,
        :hasBridge=>true,
        :boundingBox=>{:lr=>{:lng=>-104.605087, :lat=>38.265427}, :ul=>{:lng=>-104.98761, :lat=>39.738453}},
        :distance=>111.38,
        :routeError=>{:errorCode=>-400, :message=>""},
        :formattedTime=>"01:44:22",
        :realTime=>7605,
        :time=>6262}
      
      @trip = Trip.new(data, 'Denver,CO', 'Pueblo,CO')

      it 'has all attributes', :vcr do
        expect(@trip.id).to eq(nil)
        expect(@trip.start_city).to eq('Denver,CO')
        expect(@trip.end_city).to eq('Pueblo,CO')
        expect(@trip.travel_time).to eq('01:44:22')

        expect(@trip.weather_at_eta).to be_a Hash
        expect(@trip.weather_at_eta).to have_key :temperature
        expect(@trip.weather_at_eta[:temperature]).to be_a Float
        expect(@trip.weather_at_eta).to have_key :conditions
        expect(@trip.weather_at_eta[:conditions]).to be_a String
      end
    end
  end

  describe 'SAD Path' do
    before :each do
      data = {:routeError=>{:errorCode=>2, :message=>""}}

      @trip = Trip.new(data, 'Denver,CO', 'London,UK')
    end

    it 'to london is impossible and returns empty hash for weather', :vcr do
      expect(@trip.id).to eq(nil)
      expect(@trip.start_city).to eq('Denver,CO')
      expect(@trip.end_city).to eq('London,UK')
      expect(@trip.travel_time).to eq('impossible')
      expect(@trip.weather_at_eta).to eq({})
    end
  end
end
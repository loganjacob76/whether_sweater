require 'rails_helper'

RSpec.describe LocationFacade do
  describe 'class methods' do
    it '.get_coordinates', :vcr do
      coordinates = LocationFacade.get_coordinates('denver, co')
      expect(coordinates).to be_a Location
    end
    
    it '.new_trip', :vcr do
      trip = LocationFacade.new_trip('Denver,CO', 'Pueblo,CO')
      expect(trip).to be_a Trip
    end
  end
end
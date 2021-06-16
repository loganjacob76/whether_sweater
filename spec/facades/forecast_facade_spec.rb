require 'rails_helper'

RSpec.describe ForecastFacade do
  before :each do
    @facade = ForecastFacade.weather_for_city('denver, co')
  end

  describe 'class methods', :vcr do
    it '.weather_for_city' do
      expect(@facade).to be_a Forecast
    end
  end
end